Return-Path: <linux-fsdevel+bounces-29904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884BE97F1A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 22:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6D41C21920
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 20:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8601A0BE3;
	Mon, 23 Sep 2024 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnKk/sCu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1902C197A77;
	Mon, 23 Sep 2024 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727122862; cv=none; b=gqwzkS65tgp1qb0Hhr8UPvTrNrPg2mcU9RcNGwjsZsGMGwJ+NaFuKAxjP/OJuT08DXtnw2gpbsis9ap5ouo6gILTwVVkonhQKyDv7W70EG7xz4CMfps7g24DR589u2BHvObFXwM9qCHh4E5COH9VeB7maEzlcLPFtXVMpwjLttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727122862; c=relaxed/simple;
	bh=DsCb6qpLdEgMJ5yT5bmM7oaMBnnki7ouT3XEgyQdChw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jK+D+x3EGcQpidD4loIxGb7IL/pg7YlvuFxH8lp4obQNcfl42PQ3wX4+CevoCbBMrnLgMZSltHyvYweN7nvmeSM6TLwZ70GlV2juC8vksSFkjMzFod8sUgm7TBFzzzB1D8DqW3kM1LhNSLTH+XERPVlOfDxlUF2ocHv8cvK5an4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnKk/sCu; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53653ee23adso4311597e87.3;
        Mon, 23 Sep 2024 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727122859; x=1727727659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NleUZATndt1acwKzBa7y/6tS+SaA3XdbIXpdmDlWmuM=;
        b=TnKk/sCuLv5vkgPYiYZINQrsq61aMi24rCYxVeETwQm6zi5mSGlsbh1uT5Ttj6/rb5
         vJwEy4Z0ix3MwEmSSI4aEGS1L81JOvRT+8vkVRSIRBf7eLt8Xq4bI91pwDNZVSrLnOIn
         E6WSdUquC9OYz9OleyGMrM4/nFRMVxTpQ5Wzu9ZBL2WZCGT2SDqLUr/cLuqjT7Hb5vWx
         xZuipdCxVsny87xpXfqS/GR0Hmf+wa3QpBYVOUlWMif32d42fOOA2raOEZP6VJSYPr+2
         u6IaKIVs8vN+Cf/1nFpHnm8YusG+5TF7eYVjZ0RuguabFHMAEVntGLT0Z530sqtGfb6u
         8ZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727122859; x=1727727659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NleUZATndt1acwKzBa7y/6tS+SaA3XdbIXpdmDlWmuM=;
        b=g19eWJvP2pAiJ5C/yo0EYCoB9ZfhTHfwE7Jq84hcvEY2XpI9/r/sBONR/Ozc0igv9q
         9ciSgrUIVv4r5AkBXEk+R4zXJTRamnOMncxueYZPsBikBeAgyzMzr7/Bztvwf8L0Rf2V
         lFAccz/SdInJesRMWH/ejUfiB4UrwjeAnaAbES5wLGr7mA7BNiF2hQOE2eQEM7qMMYJc
         EPWIp58vwIP9HNtjOVcd934Qx8jBHp4gT7ZIL/AdkDHxSXMICkSr+NqBgJ0iYT2dJN6M
         45M1wPomBH9yshGeNIsyBpI/4QTEcwHLsROIHipACpd51zlXsn31e59vdFvwv4KXS1bj
         kunQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFzGF6omiZV+XWIybbIzrpuhJ9yb1Avrq8IxpLNNcrhp4GBSzV2rT81t8MSYXsycmSGsxUcnaVWf29@vger.kernel.org, AJvYcCVN8VQkaPLHZ+kLFlKDv3YDkS1NkkUbFmZnazji9hk9dbESY4yoJ9pwUDRYhSw8egnDzpX9HG166LT7@vger.kernel.org, AJvYcCVvVBW7hCEAnwmSWOhihuAR3nV3obE0JI9YC5czL5m1hDqMC9q0FvQYklJVl+B7HV3jMQanJy0d8YB8Pg==@vger.kernel.org, AJvYcCWTLJS3OZkmslimGd/MFJIcNi7CoILaN3P1JTFPoIMLOzwUSSv7EWHaXN/jvSQKBJf724bXEzCleWeMbeAgZg==@vger.kernel.org, AJvYcCX5C0zXtntRXDvPbIL6qaZKYDqH7n/xpeiKv6ryIQ1dAyeLbxGXtZzRXiCAqnG5QNYoyqXkcgH2Z74cwp/V@vger.kernel.org, AJvYcCXH2KTM/zFdk5lfgcw66Htl13FFO/dN0LWIoiOJKyYGDkaJJ6Cm6/oUd791wRXT6Sg13c2CBHuJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6tkieRY34dcDCKB/NymGv3VXpJcpFyv1VUIFrmK0b55hxXqAj
	bpGewHMFwgorkDwmlmaQDVKpdIeaIXqqntufm+8Tl8u20+fqKBwLNGUVaxPgtJJyZoY0vGMzzXq
	L6canLMMny7ar9TEEOeamrcJgmcs=
X-Google-Smtp-Source: AGHT+IFe6pzcf17Wh1gjew0V8YTIVeE9hLlPHLiePqr1rh/borgYiDBhQWNwMIzi8TlRjg6PaEMoWqREOxcDUAURZmM=
X-Received: by 2002:a05:6512:6c3:b0:535:63a3:c7d1 with SMTP id
 2adb3069b0e04-536ad3b7f23mr6933488e87.48.1727122858742; Mon, 23 Sep 2024
 13:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814203850.2240469-20-dhowells@redhat.com>
 <20240923183432.1876750-1-chantr4@gmail.com> <912766.1727120313@warthog.procyon.org.uk>
In-Reply-To: <912766.1727120313@warthog.procyon.org.uk>
From: Manu Bretelle <chantr4@gmail.com>
Date: Mon, 23 Sep 2024 13:20:47 -0700
Message-ID: <CAArYzrL0+tiPRhW6Z5fDp4WJgxVBeMg90A44rA=htXku0Q99eQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
To: David Howells <dhowells@redhat.com>
Cc: asmadeus@codewreck.org, ceph-devel@vger.kernel.org, christian@brauner.io, 
	ericvh@kernel.org, hsiangkao@linux.alibaba.com, idryomov@gmail.com, 
	jlayton@kernel.org, linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	marc.dionne@auristor.com, netdev@vger.kernel.org, netfs@lists.linux.dev, 
	pc@manguebit.com, smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	v9fs@lists.linux.dev, willy@infradead.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 12:38=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
> Hi Manu,
>
> Are you using any other network filesystem than 9p, or just 9p?

Should be 9p only.

We ended up reverting the whole merge with
https://patch-diff.githubusercontent.com/raw/kernel-patches/vmtest/pull/288=
.patch
as my initial commit revert happened to work because of the left over
cached .o.

FWIW, I quickly checked and virtiofs is not affected. e.g is I was to
apply https://github.com/danobi/vmtest/pull/88 to vmtest and recompile
the kernel with:
  CONFIG_FUSE_FS=3Dy
  CONFIG_VIRTIO_FS=3Dy
  CONFIG_FUSE_PASSTHROUGH=3Dy

qemu-system-x86_64 "-nodefaults" "-display" "none" \
  "-serial" "mon:stdio" "-enable-kvm" "-cpu" "host" \
  "-qmp" "unix:/tmp/qmp-895732.sock,server=3Don,wait=3Doff" \
  "-chardev" "socket,path=3D/tmp/qga-733184.sock,server=3Don,wait=3Doff,id=
=3Dqga0" \
  "-device" "virtio-serial" \
  "-device" "virtserialport,chardev=3Dqga0,name=3Dorg.qemu.guest_agent.0" \
  "-object" "memory-backend-memfd,id=3Dmem,share=3Don,size=3D4G" "-numa"
"node,memdev=3Dmem" \
  "-device" "virtio-serial" "-chardev"
"socket,path=3D/tmp/cmdout-713466.sock,server=3Don,wait=3Doff,id=3Dcmdout" =
\
  "-device" "virtserialport,chardev=3Dcmdout,name=3Dorg.qemu.virtio_serial.=
0" \
  "-chardev" "socket,id=3Droot,path=3D/tmp/virtiofsd-807478.sock" \
  "-device" "vhost-user-fs-pci,queue-size=3D1024,chardev=3Droot,tag=3Drootf=
s" \
  "-kernel" "/data/users/chantra/linux/arch/x86/boot/bzImage" \
  "-no-reboot" "-append" "rootfstype=3Dvirtiofs root=3Drootfs rw
earlyprintk=3Dserial,0,115200 printk.devkmsg=3Don console=3D0,115200
loglevel=3D7 raid=3Dnoautodetect init=3D/tmp/vmtest-initBdg4J.sh panic=3D-1=
" \
  "-chardev" "socket,id=3Dshared,path=3D/tmp/virtiofsd-992342.sock" \
  "-device" "vhost-user-fs-pci,queue-size=3D1024,chardev=3Dshared,tag=3Dvmt=
est-shared"
\
  "-smp" "2" "-m" "4G"

would work.

Manu

>
> David
>

