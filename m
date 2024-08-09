Return-Path: <linux-fsdevel+bounces-25516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A73B794CFDD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE5DB21C20
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192B8193099;
	Fri,  9 Aug 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6J4CSqJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46414D6EB;
	Fri,  9 Aug 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205579; cv=none; b=j+G0PkKYcw1AOfPOn2Je1/Mm0fA2H3yGgcrba74EbeVEaof1OsUaE8cs01/tOdOMWSHIctSR4St+xACmtEaq6FX+pYvVuk85p+600PGSV/GRJbr4RkJGcX3tBUsxxAIAR6HPvMP9tzK003Clqlo2bUsABDHSp/Rnt04TUw0vyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205579; c=relaxed/simple;
	bh=eNlRFZVwdmgHcWOmmCWosYB7NwZhPawqTCmc+BKTYuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tri8B5BDisBrr/0wZvyEKgbeGOVJyIKFnCd2oWyDs0Mz7QjOGsbZ3sS9Q/bdQqacAMJU/yxJIbnuuNKPUCQ4Po/Wg/M+sXfBRwCQhd748XeCWQVbBsjH5v+2AWTHkCfYy13XJKSOEu+biY0FcoPVnsZWvz6hqja0UGu5fUMLF50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6J4CSqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3BDC32782;
	Fri,  9 Aug 2024 12:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723205579;
	bh=eNlRFZVwdmgHcWOmmCWosYB7NwZhPawqTCmc+BKTYuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y6J4CSqJ2eT7SzvvAAE9ei2LOQRosn78FMD1Kz1zQPZCnFaRI+jfh3pqaQzzQWb7N
	 oyWliy9cl55yGBSlvhl7rI6iHdybDVBpcnXWBC1PKKfwHfb10yTGn3aHbzhYScrbK9
	 nOpmpCEtLDS7O10XBRB/VdIldXf9XOsw0LkKhzWIjR0XSWF8PM7CMULkE1ad0J2gNd
	 vsSl4yYA+KGZmlnjJGHAQdOausHsSI/KKsvbVmU2F5cfyRrQ6279jbMl2cVXzPHvof
	 0wnt5l5s7va9NR/ZTQFBdtyiIi5xsB5NrNg2sRyV/GK9V5qt2u13mylga9wKFHLkIX
	 MIuAeSswkePkQ==
Date: Fri, 9 Aug 2024 14:12:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 11/16] fanotify: disable readahead if we have
 pre-content watches
Message-ID: <20240809-zuber-editieren-d5ecc1f70810@brauner>
References: <cover.1723144881.git.josef@toxicpanda.com>
 <fead9acdf32a49c6174dc01f30cf02df642992a5.1723144881.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fead9acdf32a49c6174dc01f30cf02df642992a5.1723144881.git.josef@toxicpanda.com>

On Thu, Aug 08, 2024 at 03:27:13PM GMT, Josef Bacik wrote:
> With page faults we can trigger readahead on the file, and then
> subsequent faults can find these pages and insert them into the file
> without emitting an fanotify event.  To avoid this case, disable
> readahead if we have pre-content watches on the file.  This way we are
> guaranteed to get an event for every range we attempt to access on a
> pre-content watched file.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

Looks sensible,
Reviewed-by: Christian Brauner <brauner@kernel.org>

