Return-Path: <linux-fsdevel+bounces-76467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JemL7vXhGlo5gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 18:47:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43368F627E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 18:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 070DC3031B24
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F3E3002D8;
	Thu,  5 Feb 2026 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1SWEf6f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAAB2749CF
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313616; cv=none; b=fUH5GsMGHsm72w1VrPtyI5PdA7Z5sQ5+94y/GRZnHVkFz89DyfHGnoxluE2CTiHfCTmo69nk4Sd2jmyyH3NoVX+1gPc8tlGzqpA0r7/FmEQ9ITPrC3KOclGdd/1osHaSdsq+o7vqRRKDcvSuz51Tbqk+VJGbOmPSjQZCYpgw500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313616; c=relaxed/simple;
	bh=wnjtBBK0iqB1VvqUAEVJlOibMNEC4vdMhgnCkZgThn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dd1KJ8AJlhdUkidT5zMsBQt0a24efj5v2sfxBQzJlA2AfoVtVEgOehYpY25h09hfr0QA9BTQkQhwKXSUvj+fMAre7BQg/t6B0SYAT0Oc5rFx0Uj3dNDQnI3C3tGg8Vo4TJeANSJOpXjQZeO9qN3riIqqYRpxHx8rdDEZto1SVfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1SWEf6f; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1249b9f5703so1956561c88.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 09:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770313615; x=1770918415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=knM2pU/+KZzHJ5cQexzMehGAL415Q9KWhsuFhvbNK0A=;
        b=k1SWEf6f+dgqM7ER+/qK/Q/rGo16QQDaicchHm4Ot9ZpSzHbYT+lgLQU3WNScz1bz9
         toeAlLsh+Gx43O2C6IP3WKuFvubDK7yfr/bVUKu29JPl9Z3GOw1bUlIK/cU4xahNp3yQ
         f09YivlRorLc5b3Ty/IhHR3OC1aREYGx0FNJABeyuogwhNVYtG8rfREaX7R3TJ/AwsKF
         rfEQwaexWqKri9N4HKvouNhVrNEo8/2uKqVjajHNNza05ltyn7S5joaLA4zGMO2xLZN/
         GaH0cfKs2FEWMNJwRs4TX6kEIVEeM8DRAgsRoZbSLKvhCG0Qj0RcDhgfh7mcBwHjT+iG
         duTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770313615; x=1770918415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knM2pU/+KZzHJ5cQexzMehGAL415Q9KWhsuFhvbNK0A=;
        b=xQOXLF0YvkXuYEnLJ84aR6uox7+uv+JkfeRjwEyqnzHTmGWiI43fSpDjdazFimBNaL
         cSx2e1wYj7MMgA9A8+nSsmCgTOk6lpVjHh5kqnbj6NA+T6Pp2zTYwbza+9zVrGw4sKub
         hUCXrKKrAw2mtSC5itIsmCratQtHJClvDWD8511SZgIv8Lv0CY8z4Z0w08LZYJWVIa+d
         MAtaMROgegk5NdD0swA9wtdWzdepqb9Wv2uYuNBcrWt65fPIyiSltDKHPDeN+ue3D9V8
         V5KzGstbPU5nKp2B51DfEyvyVs5aHlIXrI/snCUar5bTMT/2r9+c1yTt3N3apw4vbMqy
         Bvng==
X-Forwarded-Encrypted: i=1; AJvYcCWa4LYvRnkfxcqHUQ/5fASQzLS4ttAXMna2HBluz+q4OfWPMHM4yw6bzjJRSerg9WquXfLkzksscldzV0KS@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQHzGtSiuk7e7yNdr/JOfoRXH9P08TwJJumMZRUGwxLcE/ZaG
	NPBNAnjfaQAG5AI+DXTDhv9CUfzOg7YCytmT5IpgjRnq1OzJ4WsvrOV6
X-Gm-Gg: AZuq6aIdyhqltCl4yzI9rINVASWaEVjFssXWSCTieCcsQtI0+WazB9Ft44yNrzolIJY
	gfVOCRxaIBFbnSBNyOMfi2qy7KqroIbKT4YKejjSsLb6z9DrQZgaomATKC9V6RNgX3o4poc8QvU
	WMOuwxCkle7alBre2vab5H99t0HrAdLkLV6dMg+K+B8zo8iDuCA8k41Gy6A6gQWyVURBVlcawb7
	gi6tND+ovXxx3qlfNUSZu63DOCg3d2z82ny8826wQuWR5hGdJ1sDBiY3nXMEJ+g1hwBuW7oNh+Z
	N34wWHBYqxqmTlz+xi8zkDV+n30Ee48kBOpFUyVNTo6zlspfaGSQCfJt9bNvfJQl5PrLG3Cm+xp
	XHwx4rvKwD9eicYggCIc0HV6r82fXffwJIe0BSjDuAz6GrMo11PXAv6Y1hpFOfpJrH1mnoahi3Y
	3zjnEy2gJlOa/lB4W7Ag==
X-Received: by 2002:a05:7022:a86:b0:123:330b:398 with SMTP id a92af1059eb24-12703f51b55mr30556c88.19.1770313615063;
        Thu, 05 Feb 2026 09:46:55 -0800 (PST)
Received: from deathstar ([2600:1700:22f5:908f:1457:7499:d258:358f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e04467sm4152626c88.2.2026.02.05.09.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 09:46:54 -0800 (PST)
Date: Thu, 5 Feb 2026 09:46:52 -0800
From: Matthew Wood <thepacketgeek@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
	Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	hch@infradead.org, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org, 
	kernel-team@meta.com
Subject: Re: [PATCH RFC 0/2] configfs: enable kernel-space item registration
Message-ID: <aYTWbElo_U_neJZi@deathstar>
References: <fdieWSRrkaRJDRuUJYwp6EBe1NodHTz3PpVgkS662Ja0JcX3vfDbNo_bs1BM7zIkVsHmxHjeDi6jmq4sPKOCIw==@protonmail.internalid>
 <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
 <878qfgx25r.fsf@t14s.mail-host-address-is-not-set>
 <-6hh70JX5nq4ruTMbNQPMoUi6wz8vmM2MQxqB3VNK3Zt97c-oxWOo3y0cQ7_h6BSfcp78fR9GmzxcTQb_WB-XA==@protonmail.internalid>
 <ineirxyguevlbqe7j4qpkcooqstpl5ogvzhg2bqutkic4lxwu5@vgtygbngs242>
 <875xakwwvz.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xakwwvz.fsf@t14s.mail-host-address-is-not-set>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76467-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,infradead.org,evilplan.org,gmail.com,wbinvd.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thepacketgeek@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43368F627E
X-Rspamd-Action: no action

Hi Breno and Andreas,

I'm in favor of this RFC as I think the current flow of needing to
create the cmdline0 dir in the netconsole configfs (when DYNAMIC config
is enabled) prior to modifying the values is not ideal.

I think there are good points shared about sysfs vs. configfs being used
for the cmdline target modification and wanted to add my thoughts.

On Fri, Dec 05, 2025 at 08:29:04PM +0100, Andreas Hindborg wrote:
> "Breno Leitao" <leitao@debian.org> writes:
> 
> > Hello Andreas,
> >
> > On Fri, Dec 05, 2025 at 06:35:12PM +0100, Andreas Hindborg wrote:
> >> "Breno Leitao" <leitao@debian.org> writes:
> >>
> >> > This series introduces a new kernel-space item registration API for configfs
> >> > to enable subsystems to programmatically create configfs items whose lifecycle
> >> > is controlled by the kernel rather than userspace.
> >> >
> >> > Currently, configfs items can only be created via userspace mkdir operations,
> >> > which limits their utility for kernel-driven configuration scenarios such as
> >> > boot parameters or hardware auto-detection.
> >>
> >> I thought sysfs would handle this kind of scenarios?
> >
> > sysfs has gaps as well, to manage user-create items.
> >
> > Netconsole has two types of "targets". Those created dynamically
> > (CONFIG_NETCONSOLE_DYNAMIC), where user can create and remove as many
> > targets as it needs, and netconsole would send to it. This fits very
> > well in configfs.
> >
> >   mkdir /sys/kernel/config/netconsole/mytarget
> >   .. manage the target using configfs items/files
> >   rmdir /sys/kernel/config/netconsole/mytarget
> >
> > This is a perfect fit for configfs, and I don't see how it would work
> > with sysfs.
> 
> Right, these go in configfs, we are on the same page about that.
> 
> >
> > On top of that, there are netconsole targets that are coming from
> > cmdline (basically to cover while userspace is not initialized). These
> > are coming from cmdline and its life-cycle is managed by the kernel.
> > I.e, the kernel knows about them, and wants to expose it to the user
> > (which can even disable them later). This is the problem I this patch
> > addresses (exposing them easily).
> 
> I wonder if these entries could be exposed via sysfs? You could create
> the same directory structure as you have in configfs for the user
> created devices, so the only thing user space has to do is to point at a
> different directory.
> 
Although technically feasible, this approach leads to an inconsistent
and confusing management of the netconsole targets. A configfs path for
user-space created targets and a sysfs path for the cmdline initiated
target that can also be modified from userspace (e.g. to update
remote_ip or userdata fields).

I think Breno's approach sets up for the most intuitive user experience.
The cmdline config for netconsole is also user-provided, so it seems
like it should behave as a pre-populated configfs target that happens to
pass from cmdline through netconsole module init to the current configfs
interface. The initial values are not determined by the kernel itself.

> 
> Best regards,
> Andreas Hindborg
> 
> 
> 

