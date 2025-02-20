Return-Path: <linux-fsdevel+bounces-42164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFF5A3D915
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 12:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6271516BD64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3B91F3FD9;
	Thu, 20 Feb 2025 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+BNbfyn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE91F30DE
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051819; cv=none; b=AzuipByPNZCWODMAG20jCE1esse9sszI/OhxJyZSn1jSZhHZjl4Y3zcQSrF8Wnm9uZAxamUmylU1zJDtOCSVLj6fXAffrEwdru3t0TP1K1r460/n4JRN3ESK3ZtWM67vcjTd8wPRSKW1ufa9Fztnax1blqw2t5i49ih1P0Zfl8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051819; c=relaxed/simple;
	bh=fUTEm9jG7+5Q0yQd7dUD8PFKxTRnfmBf+dEM7bJ5fEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGmkRfa++OU6yqNAa0nJ3dMvdhzv1GA1D8ni8921gziVw5S0E9JzI0pVDKFujQ2uo8LovFbPZwQzNP5ElS8oDXh7Xkf8b7OBo38+Ylqkj4fDDy3v597LcX2fcCZcl0BQ3NGU8ls3ssAZXhHnkz+IXgeUIVOfTTayJVcnBYy2Chk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+BNbfyn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740051815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1BaKvh9nmZplPNZ4mM70vwtiws75PwZUGLaZfHX6Iw=;
	b=T+BNbfynpeQ7pkFgjvGl/Hpb0J+kOlK2TgNlY6Q/KZjWaCd7hMUBvzQN2NrJ1tzDF9wWBg
	pWOmKTD1igFKcUMbdFV8XTV1eC6Sp1fpFzMDMzF7fsWWHyQiaX4MAWoWfOAAZQNhHqSNsg
	EV0ZpsuRn7RWRYbZLN+lm5m2kbOEJHM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-pB1OHCBnO8ufsFFOh0O2Cg-1; Thu, 20 Feb 2025 06:43:33 -0500
X-MC-Unique: pB1OHCBnO8ufsFFOh0O2Cg-1
X-Mimecast-MFC-AGG-ID: pB1OHCBnO8ufsFFOh0O2Cg_1740051812
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abb82ed9393so99445266b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 03:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740051812; x=1740656612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1BaKvh9nmZplPNZ4mM70vwtiws75PwZUGLaZfHX6Iw=;
        b=DLS04JeF1z4g15mic5igelWEzTDxN9JuokePRzp2lu1XDwJc4m33KeuNsrirY2Qc08
         yg4G2kvPt2PzBAFroIlYtF5wSg+L4y7HOZb6gB7nddKBeCy52ubMVbqsXQUc57eJ0XV9
         EpKN+Qq5Ra23QITkanreXdl4qL7++LvaYfMs4NiicT4s8euyO+u4JJArQVXvkv05ji65
         cKa4Ij0NheHTyqTo/e7Z5i/q6A1dtGEmiDrGektwrats4Ia2+0nvHGainhs27I3NLIaj
         bcvgobKEBU/8Nh2oXkCuB/8/zHFFpc4vZfBzEuyMoQXSK34ic9G6wLReKOLkaguUW5up
         lazw==
X-Forwarded-Encrypted: i=1; AJvYcCVc/oofezHgCPQ9fLDJa5BRYOvEjZeVE0ZokBKOQVJJDfNtD9fka8tpIfnhDX22lBcqJkN71KDCEolP/+IJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxlIYHrlxfiWsAhvGt7YGhdvc5DLF8BTyMO1GgoYTVIKALsVygZ
	Ir8n588xHHsPVdGPDZi3ZQkWO7w4z86BcjxfXs8h9sDxzVl3a+384YvlFrJg8Lws878l/q1hybV
	/zqWlYuraS6n+wm6vhkW7HuUUDFhN6ZD1h7E/wi8zp32Tf81ZrhkivunLCBJk+U/ZgcmBugQn2W
	iAm0xo60y3wDmJceGzro53P3DDKMNLfQlUmBiw0Q==
X-Gm-Gg: ASbGncs4f96w6z4Fku95CdJVg2sl9UQTlwEPRuhSEv/KBQuoVe755nSE0dLMgW5+wI7
	Tb5fq1Il0NOSSLtdDvyKzPAICYjD8RUT6m44lBdtWH84ztOp0QY6qs5k4STG/qg==
X-Received: by 2002:a17:907:6e94:b0:ab7:ca9:44e4 with SMTP id a640c23a62f3a-abbcccf515fmr620794966b.15.1740051812283;
        Thu, 20 Feb 2025 03:43:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjF/qLQmWeduIwi/gFBCy8i7kzGZScca4Gd8z9KFudySReQzjAU5Pgz3ik1K2OFw2Nid7nO/62lUapurvOy5E=
X-Received: by 2002:a17:907:6e94:b0:ab7:ca9:44e4 with SMTP id
 a640c23a62f3a-abbcccf515fmr620792966b.15.1740051811863; Thu, 20 Feb 2025
 03:43:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219003419.241017-1-slava@dubeyko.com> <CAO8a2SjeD0_OryT7i028WgdOG5kB=FyNMe+KnPHEujVtU1p7WQ@mail.gmail.com>
 <8b6bcbf5ba377180fed3a31115b1a20b31f0b7df.camel@ibm.com>
In-Reply-To: <8b6bcbf5ba377180fed3a31115b1a20b31f0b7df.camel@ibm.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 20 Feb 2025 13:43:20 +0200
X-Gm-Features: AWEUYZkcJPtA3NB22W1wIMC2CXuqzEai9FOvpvUbODqyuD138FZ5XTHMk729NBo
Message-ID: <CAO8a2SgWRBXH2hFg5m9Gf0Nvr5=0PZXE8n2aane6kp7G8pCO_g@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix slab-use-after-free in have_mon_and_osd_map()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Patrick Donnelly <pdonnell@redhat.com>, 
	David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's a good fix, I just want to make sure we are not leaving more
subtle correctness issues.
Adding a NULL and a proper cleanup sounds like a good practice.

On Wed, Feb 19, 2025 at 10:13=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Wed, 2025-02-19 at 14:44 +0200, Alex Markuze wrote:
> > This fixes the TOCTOU problem of accessing the epoch field after map-fr=
ee.
> > I'd like to know if it's not leaving a correctness problem instead. Is
> > the return value of  have_mon_and_osd_map still valid and relevant in
> > this case, where it is being concurrently freed?
> >
>
> Frankly speaking, I don't quite follow your point.
>
> The handle_one_map() [1] can change the old map on new one:
>
>         if (newmap !=3D osdc->osdmap) {
>                 <skipped>
>                 ceph_osdmap_destroy(osdc->osdmap);
> <--- Thread could sleep here --->
>                 osdc->osdmap =3D newmap;
>         }
>
> And have_mon_and_osd_map() [2] can try to access osdc->osdmap
> in the middle of this change operation without using the lock,
> because this osdmap change is executing under osdc.lock.
>
> So, do you mean that it is impossible case? Or do you mean that
> the suggested fix is not enough for fixing the issue? What is your
> vision of the fix then? :)
>
> The issue is not about complete stop but about of switching from
> one osdmap to another one. And have_mon_and_osd_map() is used
> in __ceph_open_session() [3] to join the ceph cluster, and open
> root directory:
>
> /*
>  * mount: join the ceph cluster, and open root directory.
>  */
> int __ceph_open_session(struct ceph_client *client, unsigned long started=
)
> {
>         unsigned long timeout =3D client->options->mount_timeout;
>         long err;
>
>         /* open session, and wait for mon and osd maps */
>         err =3D ceph_monc_open_session(&client->monc);
>         if (err < 0)
>                 return err;
>
>         while (!have_mon_and_osd_map(client)) {
>                 if (timeout && time_after_eq(jiffies, started + timeout))
>                         return -ETIMEDOUT;
>
>                 /* wait */
>                 dout("mount waiting for mon_map\n");
>                 err =3D wait_event_interruptible_timeout(client->auth_wq,
>                         have_mon_and_osd_map(client) || (client->auth_err=
 < 0),
>                         ceph_timeout_jiffies(timeout));
>                 if (err < 0)
>                         return err;
>                 if (client->auth_err < 0)
>                         return client->auth_err;
>         }
>
>         pr_info("client%llu fsid %pU\n", ceph_client_gid(client),
>                 &client->fsid);
>         ceph_debugfs_client_init(client);
>
>         return 0;
> }
> EXPORT_SYMBOL(__ceph_open_session);
>
> So, we simply need to be sure that some osdmap is available,
> as far as I can see. Potentially, maybe, we need to NULL
> the osdc->osdmap in ceph_osdc_stop() [4]:
>
> void ceph_osdc_stop(struct ceph_osd_client *osdc)
> {
>         destroy_workqueue(osdc->completion_wq);
>         destroy_workqueue(osdc->notify_wq);
>         cancel_delayed_work_sync(&osdc->timeout_work);
>         cancel_delayed_work_sync(&osdc->osds_timeout_work);
>
>         down_write(&osdc->lock);
>         while (!RB_EMPTY_ROOT(&osdc->osds)) {
>                 struct ceph_osd *osd =3D rb_entry(rb_first(&osdc->osds),
>                                                 struct ceph_osd, o_node);
>                 close_osd(osd);
>         }
>         up_write(&osdc->lock);
>         WARN_ON(refcount_read(&osdc->homeless_osd.o_ref) !=3D 1);
>         osd_cleanup(&osdc->homeless_osd);
>
>         WARN_ON(!list_empty(&osdc->osd_lru));
>         WARN_ON(!RB_EMPTY_ROOT(&osdc->linger_requests));
>         WARN_ON(!RB_EMPTY_ROOT(&osdc->map_checks));
>         WARN_ON(!RB_EMPTY_ROOT(&osdc->linger_map_checks));
>         WARN_ON(atomic_read(&osdc->num_requests));
>         WARN_ON(atomic_read(&osdc->num_homeless));
>
>         ceph_osdmap_destroy(osdc->osdmap); <--- Here, we need to NULL the
> poiner
>         mempool_destroy(osdc->req_mempool);
>         ceph_msgpool_destroy(&osdc->msgpool_op);
>         ceph_msgpool_destroy(&osdc->msgpool_op_reply);
> }
>
> Thanks,
> Slava.
>
> [1]
> https://elixir.bootlin.com/linux/v6.14-rc2/source/net/ceph/osd_client.c#L=
4025
> [2]
> https://elixir.bootlin.com/linux/v6.14-rc2/source/net/ceph/ceph_common.c#=
L791
> [3]
> https://elixir.bootlin.com/linux/v6.14-rc2/source/net/ceph/ceph_common.c#=
L800
> [4]
> https://elixir.bootlin.com/linux/v6.14-rc2/source/net/ceph/osd_client.c#L=
5285
>
>
>


