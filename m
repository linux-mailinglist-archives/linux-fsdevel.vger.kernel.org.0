Return-Path: <linux-fsdevel+bounces-21645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD5D907427
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 15:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB431F23545
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 13:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B84DF71;
	Thu, 13 Jun 2024 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGj0OYoh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530C9476;
	Thu, 13 Jun 2024 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286370; cv=none; b=JMKHCixRcdZvsWFF5PAXUm+d2690rIVlj7K6ndcsMztRDhMch6+dsxne5dSo0orJHqyzpZpp9DjDZFbVMkmfZ79gF7TQkd6zmvr/QeZaetsLh+XJV3Pl7ljdw073SqbC5LBdSz9eTeoUffnKZx2obSs1R3MNPDBIO10Hp97N1VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286370; c=relaxed/simple;
	bh=Cu61nr4nJ/DNrtNmkrPxsEW/EJFlOWsk/kIrkuXxWUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmbMpW29s0erB6Fc8caVJ3YPGkUAF0dZGT8IyVVG+RsIT9j3/LDtwvDNZmE0R3heU3AC+5IEXAR4p3YPaw2A3Y36Rw9GiFIrnCTuso9DpEY9p+KKOVO3myc4lR1MdH65p5JQB9Q7r11HGSlxj3BtwPY6LUWpsLhwTnCFThY9IzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGj0OYoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5585EC4AF1C;
	Thu, 13 Jun 2024 13:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718286369;
	bh=Cu61nr4nJ/DNrtNmkrPxsEW/EJFlOWsk/kIrkuXxWUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGj0OYohKjhr8CD2uMz4ATJRLYjk8fsoxg+FxTi2cRv3iuqRVYtkUHda1x8v1MV0m
	 avw+7Qh8JOo8Nfl5RbMyENyINEPGFGQlhmnPWs0O6ga6MJkfq/LJpky0rGkaRfSx2N
	 n/K7y0m/u/PdMtlgiwfYFX1vXmpfYqhqdeBEakJHF7W01nrvXfNK8egqLah0hIkcTg
	 xbcAO9k2/+XZvppxfwXV5HySMjlvULvzJEuClS+RsQ2fE4FQ33Gw/5hCn3Ho+5UngN
	 QMV8Gv9dH7mTGHS+Dn4B2wxYgAhlhLfpKyRiNRhOIRom9ttC3NhzL94VBeeS9GqIZ0
	 kBN2rQrCoIrOQ==
Date: Thu, 13 Jun 2024 15:46:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
Message-ID: <20240613-pumpen-durst-fdc20c301a08@brauner>
References: <20240613001215.648829-1-mjguzik@gmail.com>
 <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
 <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>

> All that aside, you did not indicate how do you want to move forward
> regarding patch submission.

I've picked Linus patch and your for testing into the vfs.inode.rcu branch.
Was trivial to fix your typo and to add Linus as author with your commit
message. Let's see what syzbot and that perf bot have to say.

