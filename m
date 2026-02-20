Return-Path: <linux-fsdevel+bounces-77817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC/NKgq7mGktLgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 20:50:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2683916A768
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 20:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 688DA303327B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 19:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D5F2F5A25;
	Fri, 20 Feb 2026 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDrzAl6u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17722DF151;
	Fri, 20 Feb 2026 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771617022; cv=none; b=GDDh/AW6maJ9Bh4HNkwoMTdG5PyDkyQNQ4XgC6vJ68IADLr2j734sbOdBvIjWOZNgd78++xaTtgUUPD1KEnVWn8gcZl7MEu5k6TsIkCRI/6UqujF0QMO5RLZ5B3TvUFa64crwBv0PSDZD5IUQSr7pP8cFwKrhaOdN3BCWtyx2KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771617022; c=relaxed/simple;
	bh=46rZAlhHO0tSGik7S4Qgw3kaq49VkdGzybXEmAOjuGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTw9W3s1+7CYrV445Itie1Hj+46AruxLk/jELYHljp5ztknuOs51/uvZjaTxrCElOvvZltzGLpf5/MF3MZtag4LWo/uw1o3Ega0khWRMMHVG7B7AXXP7UH4BT3p4+wM9UlL6MXCy61NMkwm/JXYuQ6yQCwdE0Oso5rqD7XzA5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDrzAl6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894C6C116C6;
	Fri, 20 Feb 2026 19:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771617021;
	bh=46rZAlhHO0tSGik7S4Qgw3kaq49VkdGzybXEmAOjuGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDrzAl6uzNk5PgAfQyn3GzfGAdo3ATRFHQCZOX9KPp0pgrSmVBW+LUM8tUzr3IOmo
	 pKrPFvz6yEGZTIfbLtskbXiZsK3wgfOKYXFybTyaA7T8LMMosacAC4t3NwlYQVOKGT
	 abSdcwQBm6B7qsu3MtuXIFUiNf7Ves0t47+Zd4n6y1dbvdEIDFiqSN5hNZXi8QMYs7
	 qPV9uHZg+jPEwLM+TXQLAEN8teZatZVDQ19orS+kk6V9piJb5RBoujarc6nsgeQ72r
	 O6GZESNyS7LwjcUVfJDjuAgq6s++irzvYrnoLKLtTfO6vSa20tgmgubVukycwPJ/1I
	 aaMDInQr6f/Zw==
Date: Fri, 20 Feb 2026 09:50:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, gregkh@linuxfoundation.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	jack@suse.cz, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 2/3] kernfs: Send IN_DELETE_SELF and IN_IGNORED
Message-ID: <aZi6_K-pSRwAe7F5@slm.duckdns.org>
References: <20260220055449.3073-1-tjmercier@google.com>
 <20260220055449.3073-3-tjmercier@google.com>
 <aZh-orwoaeAh52Bf@slm.duckdns.org>
 <CAOQ4uxjgXa1q-8-ajSBwza-Tkv91tFP-_wWzCQPW+PwJMehEWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjgXa1q-8-ajSBwza-Tkv91tFP-_wWzCQPW+PwJMehEWA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77817-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2683916A768
X-Rspamd-Action: no action

Hello,

On Fri, Feb 20, 2026 at 07:15:56PM +0200, Amir Goldstein wrote:
...
> > Adding a comment with the above content would probably be useful. It also
> > might be worthwhile to note that fanotify recursive monitoring wouldn't work
> > reliably as cgroups can go away while inodes are not attached.
> 
> Sigh.. it's a shame to grow more weird semantics.

Yeah, I mean, kernfs *is* weird.

> But I take this back to the POV of "remote" vs. "local" vfs notifications.
> the IN_DELETE_SELF events added by this change are actually
> "local" vfs notifications.
> 
> If we would want to support monitoring cgroups fs super block
> for all added/removed cgroups with fanotify, we would be able
> to implement this as "remote" notifications and in this case, adding
> explicit fsnotify() calls could make sense.

Yeah, that can be useful. For cgroupfs, there would probably need to be a
way to scope it so that it can be used on delegation boundaries too (which
we can require to coincide with cgroup NS boundaries). Would it be possible
to make FAN_MNT_ATTACH work for that?

Thanks.

-- 
tejun

