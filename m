Return-Path: <linux-fsdevel+bounces-40045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6CDA1B9AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 16:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E49160A29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 15:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B840B157485;
	Fri, 24 Jan 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kKNAqML1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD1156676
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733782; cv=none; b=iq64ZeBn+8V9RLINrGkb8ZIFHm7eScIFE1EX38W0dqr9iNVDbkiQCKmYc7ZfjEp1XCL7Lv1twixfkXVCfmghcb7aqkkQW2a4p6uQT/xTTTHcacpd190m4dkNYcV5vHEJUZNWcq/PGAxTW/+b3fHpI98h4EXxIouWxNsbSx05d1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733782; c=relaxed/simple;
	bh=JXIU/HRhJFOslFzs7Y5I8Q5/vTVdUyV4qgXHL6ELb74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmhaWuOlnEYRIXNqYF7p4sw4U99Z2On1TIDLp2O8C4qMOa0/j7crXVXgH8SsU+UrB3YjHDn7qUoOQGgPjTBq8Stau6cBCtj85LyqZC0+AA9g/0hB3zJezLcF5ws8hPt+y0iM1dwd3kWfOBgXj9Ib94Ne4hkUE+HxvbgLxVRBj9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=kKNAqML1; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46c8474d8daso18035861cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 07:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1737733778; x=1738338578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm6PRQ+58KnnO/05gSNDI1UU/DGC0eaSudSVsHYmldU=;
        b=kKNAqML1WPVCMbnXAVOvbt+UEKV+G6Ei86v/1mSH5TtTwuvkUdKKxsp3/XMAXbIHLZ
         ARLMkhfMRH43b2rnx+oRdT/aeGTEy41d49XI1UAX04+xl6DaOhelDsElhk+u9bXh48jO
         pBrqXyHqgQeVurm/jjjtJuncvkG6JOEFJCYLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737733778; x=1738338578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mm6PRQ+58KnnO/05gSNDI1UU/DGC0eaSudSVsHYmldU=;
        b=LGMg5vZfEp8xt++MWv5tSfsp7w4p2yRZngOUBFNl76llflJnyRwtBbYOngZRbcsHmG
         tL+R00X2JozV2cmSPTrdaZbJ60RvAKo2hfhr40r/boMkWBMSoHX671ktsMSxiYh+J4Gx
         RW84wGOdpasE+GTCZ5Ng2U+M7/yp591bPWQ5THB3lPZnM+tbFiIfgrCn3OxDxliath6C
         PUQx/22Nn/FsNSEX/n8tmlBcybH49mM9VGh+rT5OkMAx2Fh7q79wicLNizFr2rpVeqnM
         GXE6q/1gljE7lhoUxJLhmdwFT/o8N0FCs24xuMTpGmfjYIEzwMaApjwGpEKjtIOyYby3
         u+vA==
X-Forwarded-Encrypted: i=1; AJvYcCUZTPKd3h2qntoxlwzpCpTXX4m2W+KvS05auA+Gn+ywHOuVD8hg+njYoGoiBiy5o6jM1S/xiIW2Y9xAppaI@vger.kernel.org
X-Gm-Message-State: AOJu0YyIktqF/IJdZl/j/KgNXdkT6cwmfx/BXAbm/V0b5WkUCY+jpvmd
	hZv2SQyC2v0CuQo7SqVnvUvv+xtvPfSpd0f8B8ZgXSgQI9Oczc4pVXuIUnrm19bNm1SehNC8X8S
	3Ecuk22032X2UI/hHqy0+xj8UJnBxIJBuAKqppQ==
X-Gm-Gg: ASbGnctkPoAIqEbiKUv03LkbKvtxj/1s4Pa0skuYnLCE/iD1IO+FYkmmxaAmJXffF63
	DqPmywrXQePH8hSOudcbVuU5vxWsILu0zdw9l1IrcQLJ3qdRq8eYErkSaJ6eg
X-Google-Smtp-Source: AGHT+IFqquliq7HIV96YWV3XAxaZDHz3BuJORL/akaDIVudNtsDg1MClagGxFhuwi/4oxTQvs9U2X4mqMWMQUElMydM=
X-Received: by 2002:ac8:5dc9:0:b0:467:681c:425c with SMTP id
 d75a77b69052e-46e12a0c0f2mr447495461cf.1.1737733778671; Fri, 24 Jan 2025
 07:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123194108.1025273-1-mszeredi@redhat.com> <20250123194108.1025273-5-mszeredi@redhat.com>
 <20250124-abklopfen-orbit-287ed6b59c61@brauner>
In-Reply-To: <20250124-abklopfen-orbit-287ed6b59c61@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 24 Jan 2025 16:49:28 +0100
X-Gm-Features: AWEUYZkqDlmuMcNW-5_UjhqZV7-dejOlo_fdpN5dbcCjLjywZlEGET6if1Se7t4
Message-ID: <CAJfpegvK9Q_uE-O8HkzzjeNh7nZ_sO89=OCyw_SZCudfXbB2JQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] vfs: add notifications for mount attribute change
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-security-module@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Jan 2025 at 16:38, Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, Jan 23, 2025 at 08:41:07PM +0100, Miklos Szeredi wrote:
> > Notify when mount flags, propagation or idmap changes.
> >
> > Just like attach and detach, no details are given in the notification, only
> > the mount ID.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
>
> I think this is a good next step but I would first go with the minimal
> functionality of notifying about mount topology changes for v6.15.

I can totally relate to that.   I added the fourth patch more as a
"let's see if this can also fit into the current framework".

> Btw, if we notify in do_remount() on the mount that triggered
> superblock reconfiguration then we also need to trigger in
> vfs_cmd_reconfigure() aka fsconfig(FSCONFIG_CMD_RECONFIGURE) but the
> mount that was used to change superblock options is only available in
> fspick() currently. That would need to be handled.

No, if we'd want to watch changes on super blocks, then we'd need to
iterate all the mounts of the superblock and notify each.

I'm not sure if it's something we really want, watching the super
block itself for changes sounds saner.

Thanks,
Miklos

