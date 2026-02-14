Return-Path: <linux-fsdevel+bounces-77205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 02nfJiVqkGmAZQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:27:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E398E13BD92
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 13:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57F68301E3D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 12:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4542F83A0;
	Sat, 14 Feb 2026 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKztIBGb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229F2DC792
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771072030; cv=none; b=DQFbWJ/A5nkwLKPO3sDHRsXOXK7c9eU3vaC+zo465cCytOtvPh3fvHJ+bhOgBpdqG3I9SHABeEXy+DYpm7MxK8VUXK7pUWVscy5CDPBfFhL91Ba3weGhPYMh/2/2Cl5mtxGDec1Zpc9EiE2q98HUlf/j4tJufZzaTO0zOJfAKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771072030; c=relaxed/simple;
	bh=D3sJvJ74sTUTA8uPb+eVNmVpMq9mQ0hhj3Uwf0nCNIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2imchpqgS6HRxJVKhhxvU3WU7QgbJ1xHFi9NuzJ8zHD1R9GIvnLWyD/kAplAjIMs15LVpbo2xO2aL4uBkktLmDu0VXfNZ0GwgNLB3P3PUsGHGFfqXtFoNBovke9TxQYBDkvF6cPTEXk+aNteOcUcIdsdUDq2+yqNM+DZag3Yjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKztIBGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C737C16AAE;
	Sat, 14 Feb 2026 12:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771072029;
	bh=D3sJvJ74sTUTA8uPb+eVNmVpMq9mQ0hhj3Uwf0nCNIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKztIBGbqxJaR8HGZrCpkTfbZTWrYKsxn3FUwGmT0q2zDE6Jsu8tIYGC3+7T/M/sN
	 tG9HR5wW6SPVkNasgejpqrG4x54wt9YBgZXehkd3FTHy7iOA4+AwZdOi/0B2rGrBKA
	 6xEbBYD5qGlUUp0iacwsNoXPAlbHXnz+TgaWJz3GKL9IvsvbeT3CRe3KnMsWifqgUC
	 vbn4nRxTEmgCok9Azj37erJEHH3F4sh0WfA1QcIv+MI/o6PY9WUGgWtlhATm4Rs4QP
	 ukPnI7xsmB5dNrUIeppDuwdVRb0xVDDLLI6MSZzzg/JfIOqPkHX8cSe0b59MHMTOCK
	 iVfXXnre9b6+A==
Date: Sat, 14 Feb 2026 13:27:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: luca.boccassi@gmail.com, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io
Subject: Re: [PATCH] pidfs: return -EREMOTE when PIDFD_GET_INFO is called on
 another ns
Message-ID: <20260214-galaktisch-drama-a8d595e525ec@brauner>
References: <20260127225209.2293342-1-luca.boccassi@gmail.com>
 <86ac574b-550c-44cc-ab9f-8c69735497e3@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86ac574b-550c-44cc-ab9f-8c69735497e3@sirena.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77205-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,brauner.io];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E398E13BD92
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 05:01:42PM +0000, Mark Brown wrote:
> On Tue, Jan 27, 2026 at 10:51:37PM +0000, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <luca.boccassi@gmail.com>
> > 
> > Currently it is not possible to distinguish between the case where a
> > process has already exited and the case where a process is in a
> > different namespace, as both return -ESRCH.
> > glibc's pidfd_getpid() procfs-based implementation returns -EREMOTE
> > in the latter, so that distinguishing the two is possible, as the
> > fdinfo in procfs will list '0' as the PID in that case:
> 
> This is in today's next and is triggering a failure in the LTP pidfd06
> testcase:
> 
>   ioctl_pidfd06.c:44: TFAIL: ioctl(pidfd, PIDFD_GET_INFO, info) expected ESRCH: EREMOTE (66)
> 
> which is the change that the changelog says will be introduced however
> the commit log for the LTP test says:
> 
>     Verify that ioctl() doesn't allow to obtain the exit status of an
>     isolated process via PIDFD_INFO_EXIT in within an another isolated
>     process, which doesn't have any parent connection.
> 
> which does sound like there might actually be a problem but I've made no
> effort to investigate.

Thanks for reporting. This is an intentional change. :)

