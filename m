Return-Path: <linux-fsdevel+bounces-46117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEABBA82CC5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 18:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B20C8A0995
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0752E26FA78;
	Wed,  9 Apr 2025 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8POyYtH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580A26772C
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216882; cv=none; b=oO33CSVxlsp4acMFamt25qGh1Sn30Paldm8Z14Ilpk3D98BCzMDnanS8MEmZaJxk4bfXMVfULselLNVYbtWgLe4eyyI03eaM9YEiGD3fWfx/ldn+x6vBESy+1A745Dc7zk1/ywTNeuKS0jc5lrOTNe9hqpWI7VFcMTNVDa6n0rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216882; c=relaxed/simple;
	bh=LFzjRlHP58WYddt2JQzoAgF2hPWegnLNbBxpK5k40fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNSzNy3ssB/WLU5+00bNAFBc+vawKdg2+tKCBZ2F6Nom4tbH7kFaivbeNsJ35hi1yodyhqZsnCd8Nb1s3cfBboyGQ284l0mimWV7hctY8CB/madpLmEibcv0yPz1c748ZY4D9NyOJGPVkpgILjO6w9CxYEZDU8zy+6qa2aWbotc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8POyYtH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744216879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u36fvjFtGQQGPvbO3308W/6GduN68vFneYmXVnvzh1s=;
	b=C8POyYtHXjTP3uCUZs7ozJtbO5DnkkQ8qJRHN9i3jt13URH3snYj+F6ZiQjMTO1fvzgKVp
	r9pMgjNQCTRfNVGUHgwaxPkvRd4+ojnFOayN7WpZTgDyLkAdN3hRLbdNDk0sDF3az/MYY6
	JvhpQ/v/Ot1h55n7YhMedXMTE18YbJU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-en0srRvwNQyukBzIwYkrZA-1; Wed, 09 Apr 2025 12:41:18 -0400
X-MC-Unique: en0srRvwNQyukBzIwYkrZA-1
X-Mimecast-MFC-AGG-ID: en0srRvwNQyukBzIwYkrZA_1744216878
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4766afee192so180408991cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Apr 2025 09:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744216878; x=1744821678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u36fvjFtGQQGPvbO3308W/6GduN68vFneYmXVnvzh1s=;
        b=khTt2IqXq11SzAzsOv0voAgh6TJYZBIl85ERhVdYelgRF5KXqRG/V8kHpGOd5ThjF5
         TEoW3GwzvHTv6U0OsQghsOwhXRD23uj71FjHYlWsmPRwTAr7C5Fpd3VXgAhotJpXcjPw
         nL6aN5Fk6IwFm7c1YzNr/w30S8D/g/JSEI2xmLvapM4yJCSd9RRvEKbBCL0MhEu/Hes9
         0QQAxb65o5M3dKWumvNGAifvH/ODRmbsAYCIztIoIJ66WFsAQdew3IHDfLbqHxhN/+KB
         krnpDfvcoViMqo6dI1dSxlldzsmy1UI9e8WkEoE9cUnhX+r58t76b6uWqK0uXxR1u7sg
         yjhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsQhq/CuTbyIH9W9pkeQPsCMqReb8/tS9L02OP0q/e80n8tkpjMy7W/Nxp5/3PjX3uMxJiepWr8lJqz3JT@vger.kernel.org
X-Gm-Message-State: AOJu0YyEjGYGDUWJYzn1cwy08GhDVISQigWkDmHKqz7Nd1XScMBO4HD8
	tI1aYbt0CCihWatYW368PWagoLD8K5xyGbG2PNQt70hilwcSd1NQp0Fq+Tdp279IYDb5ldWRyCF
	0fNePT2B2RlKFWXVWfVSG2OfNR8IQN1zEzBDl29nkOPX8iFE68xefe4Y/sPJHY/E=
X-Gm-Gg: ASbGncupvrwh6xhM0/jAqDCHZ3h8vZWolrEPFkeUQx8wD5FhJ0Pw9LHGyekQoAxEEGV
	3DGE1DjU2ZrcadnHTRA4zmmcJWMp4JwXGNFb/tRUEm5bU8VWT7pQupL812BhZSgtq5LVddgFhIf
	sFbphBSY0ap8l8p7NHiYSnlDH8520EqqULlZSYtBr/QCCk+1HZmZncoilz4woMr4bg/0IdGpvMM
	RAFfR6ZWzQ+OX3LQoBDOdzCiu4g6JNtYUpXJ+RG3Y1KfezNgkm4wz7vSfptFJ+IU6r4o9ZBB7CL
	V5qXkvTlEnQa9SQyy7si1oiIFqDv1aUM7AcnotvOlhjH+AzbAVnfybo=
X-Received: by 2002:a05:622a:1a0c:b0:476:6f90:395e with SMTP id d75a77b69052e-479600a8a0emr50360341cf.21.1744216877737;
        Wed, 09 Apr 2025 09:41:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO4Ll+hkTGnpbMHgI6Rh64gexYzHgzyCZesnMCv/qeydPl1RejXVPlhADf4PUXiDZhoJk95w==
X-Received: by 2002:a05:622a:1a0c:b0:476:6f90:395e with SMTP id d75a77b69052e-479600a8a0emr50360031cf.21.1744216877443;
        Wed, 09 Apr 2025 09:41:17 -0700 (PDT)
Received: from localhost (pool-100-17-21-114.bstnma.fios.verizon.net. [100.17.21.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47964d71a4esm9143961cf.2.2025.04.09.09.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 09:41:16 -0700 (PDT)
Date: Wed, 9 Apr 2025 12:41:15 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <fviov5jz4sga2qyexil57xz2egdjf2rz43qfr4jcozycgbovah@qptpvswdu2ia>
References: <20250408210350.749901-12-echanude@redhat.com>
 <mey7l4rm7r5fxndlg72jfjjwwctyoimjg35jetrnv5gbee4qll@w5ldyvm6h22a>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mey7l4rm7r5fxndlg72jfjjwwctyoimjg35jetrnv5gbee4qll@w5ldyvm6h22a>

On Wed, Apr 09, 2025 at 03:04:43PM +0200, Mateusz Guzik wrote:
> On Tue, Apr 08, 2025 at 04:58:34PM -0400, Eric Chanudet wrote:
> > Defer releasing the detached file-system when calling namespace_unlock()
> > during a lazy umount to return faster.
> > 
> > When requesting MNT_DETACH, the caller does not expect the file-system
> > to be shut down upon returning from the syscall. Calling
> > synchronize_rcu_expedited() has a significant cost on RT kernel that
> > defaults to rcupdate.rcu_normal_after_boot=1. Queue the detached struct
> > mount in a separate list and put it on a workqueue to run post RCU
> > grace-period.
> > 
> > w/o patch, 6.15-rc1 PREEMPT_RT:
> > perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
> >     0.02455 +- 0.00107 seconds time elapsed  ( +-  4.36% )
> > perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
> >     0.02555 +- 0.00114 seconds time elapsed  ( +-  4.46% )
> > 
> > w/ patch, 6.15-rc1 PREEMPT_RT:
> > perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
> >     0.026311 +- 0.000869 seconds time elapsed  ( +-  3.30% )
> > perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
> >     0.003194 +- 0.000160 seconds time elapsed  ( +-  5.01% )
> > 
> 
> Christian wants the patch done differently and posted his diff, so I'm
> not going to comment on it.
> 
> I do have some feedback about the commit message though.
> 
> In v1 it points out a real user which runs into it, while this one does
> not. So I would rewrite this and put in bench results from the actual
> consumer -- as it is one is left to wonder why patching up lazy unmount
> is of any significance.

Certainly. Doing the test mentioned in v1 again with v4+Christian's
suggested changes:
- QEMU x86_64, 8cpus, PREEMPT_RT, w/o patch:
# perf stat -r 10 --table --null -- crun run test
    0.07584 +- 0.00440 seconds time elapsed  ( +-  5.80% )
- QEMU x86_64, 8cpus, PREEMPT_RT, w/ patch:
# perf stat -r 10 --table --null -- crun run test
    0.01421 +- 0.00387 seconds time elapsed  ( +- 27.26% )

I will add that to the commit message.

> I had to look up what rcupdate.rcu_normal_after_boot=1 is. Docs claim it
> makes everyone use normal grace-periods, which explains the difference.
> But without that one is left to wonder if perhaps there is a perf bug in
> RCU instead where this is taking longer than it should despite the
> option. Thus I would also denote how the delay shows up.

I tried the test above while trying to force expedited RCU on the
cmdline with:
    rcupdate.rcu_normal_after_boot=0 rcupdate.rcu_expedited=1

Unfortunately, rcupdate.rcu_normal_after_boot=0 has no effect and
rcupdate_announce_bootup_oddness() reports:
[    0.015251] 	No expedited grace period (rcu_normal_after_boot).

Which yielded similar results:
- QEMU x86_64, 8cpus, PREEMPT_RT, w/o patch:
# perf stat -r 10 --table --null -- crun run test
    0.07838 +- 0.00322 seconds time elapsed  ( +-  4.11% )
- QEMU x86_64, 8cpus, PREEMPT_RT, w/ patch:
# perf stat -r 10 --table --null -- crun run test
    0.01582 +- 0.00353 seconds time elapsed  ( +- 22.30% )

I don't think rcupdate.rcu_expedited=1 had an effect, but I have not
confirmed that yet.

> v1 for reference:
> > v1: https://lore.kernel.org/all/20230119205521.497401-1-echanude@redhat.com/

-- 
Eric Chanudet


