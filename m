Return-Path: <linux-fsdevel+bounces-24109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33249398A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 05:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19855282264
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 03:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7244A13B2A8;
	Tue, 23 Jul 2024 03:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="G3XEZH8B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D279134407
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721705689; cv=none; b=utmS8cMBWR3rc/+MXTPJ0Rd4hnkAip8CxVAfLJ/W9qcOcQOzuDyZd38TTjhDeHnEAl0XM6IrIBYwrbL+NG+Zm9Gbsjd14PNJH47lCRb1GmoImjYvTui2bs+jhgCb39/0s3+Hkb2wUW7103RggeYpzUjbi/AOw5r4jsyp3+K1698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721705689; c=relaxed/simple;
	bh=Wy//HDKOsBE6f76+BhG2quuvrGFpTxUnea6ZwsKdAuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPqiSiO+wCWGVwT4HrvCBCz0UO2MoXw1q7BCK3KdrYpiHmlOjmV3OSz4gbosHrwSF136US6YBOxVp+i0SLxCMF/Y8vvSsG2F4IaNHlwonjmcFN1v/TfAl+cFLGjtxcj4Yy9jM6X83p+qnQ+CBmrcrJp1MoiLoxPC7jfIj47VJLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=G3XEZH8B; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24c0dbd2866so2489137fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2024 20:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1721705687; x=1722310487; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=odhMre96IuepQxSDaxhNjNarvTL+5+GbuLCBFloWAss=;
        b=G3XEZH8BlPZ2xJer8MIhfSjFKknlbYrmw8Z8qk2i+WgmeJP76EGGkDarJUvB06cacy
         PvPi06MSpsSl4jvJzO/ss9f6VZUzgirNdxVWwKHIH4SoGDTqVP+6DJ0lcuenZ6cxnTvj
         SJ2qqIUvZM6xMzkXdnf6HsCPKer8BDOpTYXp85pK49j/GLwqSEvkpWkCjWV34WxZgIWv
         57Fxh5TZBSqFxQHqHnlDUXH1tIEb2jo5HNWfiY22Txvi1QHeKzMqm75pvorUB+CEizdR
         tS9BFs7sbKNGgm5EuoPv4sIOnkN7YTTnHMgSvtxCWOcRy5rGVh4ZkpCoeMH98Gjo7e1e
         A6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721705687; x=1722310487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odhMre96IuepQxSDaxhNjNarvTL+5+GbuLCBFloWAss=;
        b=Jz0YegzUS4S4Wz3JMwvwIzsnEac2s2FkGq33bpXEyMpf4du2Kbqji1W9Uqmzip0AgX
         KKhS2i+UJCaM0nYZ5yDGsV5xoaPlwZloFlKxsvdqbrPmNWM849eo6VkqFiVY1NY4EmQv
         rBw2nkxvqf393a0w0PtRV6hwGLubSg/fpttzVLRNI4FXdX6pNQTpHrJt+kQ8Hu48VPg/
         nA7uFGhVnu1vfwnJxkk2w+YYANnQtIQ6rBzaTlxmIgoNnYsdKOKhWimI9WFq/TSOodPb
         era8HeY/nGj6mITzqdncpa8Db0hS8ao8KTErUt4uskldvlWs8ES3aOZwMEDMmzTE3tZt
         d/Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVsBhd+oOIqdHBZrf7vVkt0RnoSqgi45acOA9Fs99ImKmel3TwLvokvYcb2I3cyuWv6/C6f3ayw7nXa5eqxkP/JqkBDGfP5OyO7GHElTg==
X-Gm-Message-State: AOJu0Ywx/aF7ZNT1XSkDdWIXCyGiSyHuJIMMtOjFVJh4AXHo5DRHeSEQ
	q38Sz4JLDLBKwdJgIaTLYsa0QoSqTjst77Z0Wrnwt36Vxa/JfVbBP05h2dtBmxo=
X-Google-Smtp-Source: AGHT+IFuizr6yBlxfFzr/VooOJme/aR+1mm8qjWN3Qfscmq972ay9+yrA60/QR8RQS6hkaK1UBulzw==
X-Received: by 2002:a05:6871:7896:b0:25e:1711:90e3 with SMTP id 586e51a60fabf-2612130d34bmr9655696fac.2.1721705687247;
        Mon, 22 Jul 2024 20:34:47 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d270cab28sm2656949b3a.115.2024.07.22.20.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 20:34:46 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sW6IW-0083su-0e;
	Tue, 23 Jul 2024 13:34:44 +1000
Date: Tue, 23 Jul 2024 13:34:44 +1000
From: Dave Chinner <david@fromorbit.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Matus Jokay <matus.jokay@stuba.sk>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
Message-ID: <Zp8k1H/qeaVZOXF5@dread.disaster.area>
References: <20240710024029.669314-2-paul@paul-moore.com>
 <20240710.peiDu2aiD1su@digikod.net>
 <ad6c7b2a-219e-4518-ab2d-bd798c720943@stuba.sk>
 <CAHC9VhRsZBjs2MWXUUotmX_vWTUbboyLT6sR4WbzmqndKEVe8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRsZBjs2MWXUUotmX_vWTUbboyLT6sR4WbzmqndKEVe8Q@mail.gmail.com>

On Mon, Jul 22, 2024 at 03:46:36PM -0400, Paul Moore wrote:
> On Mon, Jul 22, 2024 at 8:30 AM Matus Jokay <matus.jokay@stuba.sk> wrote:
> > On 10. 7. 2024 12:40, Mickaël Salaün wrote:
> > > On Tue, Jul 09, 2024 at 10:40:30PM -0400, Paul Moore wrote:
> > >> The LSM framework has an existing inode_free_security() hook which
> > >> is used by LSMs that manage state associated with an inode, but
> > >> due to the use of RCU to protect the inode, special care must be
> > >> taken to ensure that the LSMs do not fully release the inode state
> > >> until it is safe from a RCU perspective.
> > >>
> > >> This patch implements a new inode_free_security_rcu() implementation
> > >> hook which is called when it is safe to free the LSM's internal inode
> > >> state.  Unfortunately, this new hook does not have access to the inode
> > >> itself as it may already be released, so the existing
> > >> inode_free_security() hook is retained for those LSMs which require
> > >> access to the inode.
> > >>
> > >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >
> > > I like this new hook.  It is definitely safer than the current approach.
> > >
> > > To make it more consistent, I think we should also rename
> > > security_inode_free() to security_inode_put() to highlight the fact that
> > > LSM implementations should not free potential pointers in this blob
> > > because they could still be dereferenced in a path walk.
> > >
> > >> ---
> > >>  include/linux/lsm_hook_defs.h     |  1 +
> > >>  security/integrity/ima/ima.h      |  2 +-
> > >>  security/integrity/ima/ima_iint.c | 20 ++++++++------------
> > >>  security/integrity/ima/ima_main.c |  2 +-
> > >>  security/landlock/fs.c            |  9 ++++++---
> > >>  security/security.c               | 26 +++++++++++++-------------
> > >>  6 files changed, 30 insertions(+), 30 deletions(-)
> 
> ...
> 
> > Sorry for the questions, but for several weeks I can't find answers to two things related to this RFC:
> >
> > 1) How does this patch close [1]?
> >    As Mickaël pointed in [2], "It looks like security_inode_free() is called two times on the same inode."
> >    Indeed, it does not seem from the backtrace that it is a case of race between destroy_inode and inode_permission,
> >    i.e. referencing the inode in a VFS path walk while destroying it...
> >    Please, can anyone tell me how this situation could have happened? Maybe folks from VFS... I added them to the copy.
> 
> The VFS folks can likely provide a better, or perhaps a more correct
> answer, but my understanding is that during the path walk the inode is
> protected by a RCU lock which allows for multiple threads to access
> the inode simultaneously; this could result in some cases where one
> thread is destroying the inode while another is accessing it.

Shouldn't may_lookup() be checking the inode for (I_NEW |
I_WILLFREE | I_FREE) so that it doesn't access an inode either not
completely initialised or being evicted during the RCU path walk?
All accesses to the VFS inode that don't have explicit reference
counts have to do these checks...

IIUC, at the may_lookup() point, the RCU pathwalk doesn't have a
fully validate reference count to the dentry or the inode at this
point, so it seems accessing random objects attached to an inode
that can be anywhere in the setup or teardown process isn't at all
safe...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

