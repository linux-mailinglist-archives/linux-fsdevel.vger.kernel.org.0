Return-Path: <linux-fsdevel+bounces-21255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D214890089B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8005F1F25307
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1AC194A5F;
	Fri,  7 Jun 2024 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1++oFFx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DDE15B133
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773650; cv=none; b=VpOwLif/Ek2BqLlkHN17jkREPDhmtLFwT/c8dZ/M0XMjjDJGwnAVGyDcMU75StIG7p/cIvydQPsv6NuCHF6Cse7iK7Nf403jcB17ZxmjUs6gWLIpKPre9rUt2oIfPGCivvmEkhxh0RLCnheO3HZ83GqYfk9io9EOPlA4XzOFYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773650; c=relaxed/simple;
	bh=0FIURak2iFKuQhl1WxAXgTDwmV6PA82bMdIPPaKp5X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKGUzMiQtRJJ5lGj1S+ptszvMKJJpjwMiHApM3R+A/Tj1Ts54PfmXwBY9ocpZvVDj03e2TVHN1XeC2OX8oC0MonqRLvXCZS9beHpT/mRILTT6YrDiweIEJMQCjkED0Ke5pzDKl9AEc3WvyC4fot4flPzKVbrLevLqX1viN+fj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1++oFFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BF4C2BBFC;
	Fri,  7 Jun 2024 15:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717773649;
	bh=0FIURak2iFKuQhl1WxAXgTDwmV6PA82bMdIPPaKp5X4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1++oFFxMkIP629fn+fd72NHLQrPYV6D4rR0mwifEFXh/5tGnksugfeXJjz8r5kGs
	 L3DPp99LmDHGLQDcp4uDqxxtXG+fCmCcRyWD2Rs90pfBKbtVRvvJIhpMeGUmH+0wdw
	 KBZitiy+DL+Z54oK0u9lk4DaYNVi5atSWIepAHvhvuGjiwYOGYnX/rUnrCpqzzzPp8
	 Yc6lHGaqVj2wFNo5dcnRENRydWhM6umIQXyacSDMYAsdOnC08T8j6iqoqnF3Ut4IFT
	 RieQQt28irp0pA8oWmrCfLJK3dnka6aHPZg+UzyLv7ePdhAuqPxps0m7Yldolr32Kk
	 FQU99rPRB4Blw==
Date: Fri, 7 Jun 2024 17:20:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 08/19] fdget_raw() users: switch to CLASS(fd_raw, ...)
Message-ID: <20240607-dissens-vorwiegend-a209b6770442@brauner>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
 <20240607015957.2372428-8-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240607015957.2372428-8-viro@zeniv.linux.org.uk>

On Fri, Jun 07, 2024 at 02:59:46AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

