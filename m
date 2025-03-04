Return-Path: <linux-fsdevel+bounces-43170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9D8A4EE14
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 21:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9E63A98F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 20:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DF824EAB2;
	Tue,  4 Mar 2025 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+qL/XpU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ED01FA243
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118953; cv=none; b=f2b5Nb+JcFhuZ3TG+xwmjzzXV6tEH3A4al8aoeiJhROrJzTC2iuecNOOVtMk9Axzri+Imiimffys3siU9wmyZ1deC6eoQgmMPdT/nW5nTch50EzUf/ix3F7EiZFXa97R6M61FPabDF34bPMW/VkvOc2HBlKEgoymsLnW+Ia5Mjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118953; c=relaxed/simple;
	bh=Sqelx4r6HUD5yMsMSbcysMD7vTvl8MD5Pyq9C+pSN1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhsCVfVNb+dPrFLS4gzrZSGcSDYH6XkHOPSef7TN8phjRv2Tq87xcjIl0DzU6174UNQqVv7Wi+jThhTVwy2g6LdloC4I0Rpijo7HsGwvRVEFmyf2jT2tfjNdQn/xlgL9hU3R5NAjCCZSoucIeKiWmKLiQOgrnIh/BpBGRDuxPxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+qL/XpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA463C4CEE5;
	Tue,  4 Mar 2025 20:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741118952;
	bh=Sqelx4r6HUD5yMsMSbcysMD7vTvl8MD5Pyq9C+pSN1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+qL/XpUn02yX/fdNwmBQ/5ewQ17klCSCpiUO7rhOH8H55M6ogCDLz4hGNbgNHrOZ
	 pKcsafr7fTg/b5S9qpH0VKoY98dLpwgrHikUfkdIve6V9mob9DELJsjyYkPv6OeeAj
	 odMjK+teEoFMGxROV0SudduDW+BWHaR7QtzwKxnnQcqPouM4gIamV/m/tVsPGyZgnW
	 E0BYBeNmXbmd/Chm6WgBjD85Qu0Nvd7L2BatG3w3ogGYbY2p4yzENGE5S6iMUs/tbQ
	 EuavvfenCU7iBfh10i2HXdrd8Xohbleh1hDmSe0iPHHiJInaTxjIVx6yiNKqpJixAI
	 NF19oFEzSUzQA==
Date: Tue, 4 Mar 2025 21:09:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v2 06/15] pidfs: allow to retrieve exit information
Message-ID: <20250304-wochen-gutgesinnt-53c0765c5e81@brauner>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
 <20250304-work-pidfs-kill_on_last_close-v2-6-44fdacfaa7b7@kernel.org>
 <20250304173456.GD5756@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304173456.GD5756@redhat.com>

On Tue, Mar 04, 2025 at 06:34:56PM +0100, Oleg Nesterov wrote:
> On 03/04, Christian Brauner wrote:
> >
> > +	task = get_pid_task(pid, PIDTYPE_PID);
> > +	if (!task) {
> > +		if (!(mask & PIDFD_INFO_EXIT))
> > +			return -ESRCH;
> > +
> > +		if (!current_in_pidns(pid))
> > +			return -ESRCH;
> 
> Damn ;) could you explain the current_in_pidns() check to me ?
> I am puzzled...

So we currently restrict interactions with pidfd by pid namespace
hierarchy. Meaning that we ensure that the pidfd is part of the caller's
pid namespace hierarchy. So this check is similar to:

pid_t pid_nr_ns(struct pid *pid, struct pid_namespace *ns)
{
        struct upid *upid;
        pid_t nr = 0;

        if (pid && ns->level <= pid->level) {
                upid = &pid->numbers[ns->level];
                if (upid->ns == ns)
                        nr = upid->nr;
        }
        return nr;
}

IOW, we verify that the caller's pid namespace can be found within the
pid namespace hierarchy that the struct pid had a pid numbers allocated
in.

Only that by the time we perform this check the pid numbers have already
been freed so we can't use that function directly. But the pid namespace
hierarchy is still alive as that won't be released until the pidfd has
put the reference on struct @pid. So we can use current_in_pidns().

Is that understandable?

