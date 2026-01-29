Return-Path: <linux-fsdevel+bounces-75840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFPqNHkee2msBQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 09:46:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C80CADB00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 09:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0F7730598B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 08:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DA937B417;
	Thu, 29 Jan 2026 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIpJ7esg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E747377562;
	Thu, 29 Jan 2026 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769675888; cv=none; b=IFYPR9Za9W0e/ljwAF7VOP/lAbBYsNOvi/VR+Y51QM3iilMTU9EEPyIVdvV8su4K6Z/XHsMHpVr2+FaSIXsp+Uuse1Fv8xrbhW4qkrZsn5dYR0dk6rzE8wplSaeHJZEHbuZ7rA7MvTm16TZTUBUM97djrZ8TiGFYzQZ4o9AVHlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769675888; c=relaxed/simple;
	bh=psYjG1UusZhW3q4FunD3OFstJ/UcRbNIN0k/NkFAGKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyAWSWwxnIBsYkmwZoRG6+wLcggTzxm3+VWrrvx6bn3YRW2OgjyH/7JMME8OJQ5NClK6P1/nTQE1GuTyGk/Luhi/nK8Ea79SAPrdwviaPOKEiD9TcM17gKfBz1SY66jfR6/JnxpXxDrJbELz+7CbyZn8eUFDUfd4rldz+Vu3Jug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIpJ7esg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532DFC4CEF7;
	Thu, 29 Jan 2026 08:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769675886;
	bh=psYjG1UusZhW3q4FunD3OFstJ/UcRbNIN0k/NkFAGKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIpJ7esgAYw0PrvReZuKFG9x6VjuiEvXkptdGII1dAdZIHYA8o1I6teJ0nFrVUrDI
	 gVwCPyHceiDRL/kCdRWY8UnQP8odUc9nTuZXdeOt3SOsZl6XRtARwj75kYttUr23Ub
	 hHixwdZYglsNJJLcHtZv9/reAta1WMpBwPj5GucsP/12gbpvsx+13wxBumJ7XINoA5
	 ewxQpxmV65FhH9fIpAWYOhoAp5u9DXiCbVsnoH093DvMA+/+8pyPAjGpVkQQ/L6C7j
	 ZGGEBd6DjB1U0h8LfE6NAA528W+3vbUW9Lt7ctNCt+mjJZjpyxgDGwZcFp+oPp27UT
	 9PrDeog+CEP5A==
Date: Thu, 29 Jan 2026 09:38:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Qing Wang <wangqing7171@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 3/3] ovl: use name_is_dot* helpers in readdir code
Message-ID: <20260129-lagebericht-ziehen-605070b5467a@brauner>
References: <20260128132406.23768-1-amir73il@gmail.com>
 <20260128132406.23768-4-amir73il@gmail.com>
 <20260129001443.GE2024@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260129001443.GE2024@quark>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75840-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,szeredi.hu,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C80CADB00
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:14:43PM -0800, Eric Biggers wrote:
> On Wed, Jan 28, 2026 at 02:24:06PM +0100, Amir Goldstein wrote:
> > +		if (name_is_dot_dotdot(p->name, p->len)) {
> > +			goto del_entry;
> >  		}
> [...]
> > +		if (name_is_dot_dotdot(p->name, p->len)) {
> > +			continue;
> >  		}
> 
> Should drop the braces in the above two places, as noted by checkpatch.

I'll do that when I apply.

