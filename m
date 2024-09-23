Return-Path: <linux-fsdevel+bounces-29891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABC597F0CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 20:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D758A282DF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 18:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BDA1FA5;
	Mon, 23 Sep 2024 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GELGhvkt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB02DF59;
	Mon, 23 Sep 2024 18:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117004; cv=none; b=WfvmMRE1CG2hDHA6rLmTsVtyMIRXs/ty2oJ0nz7Gw09q2cGkb+SlN7DUzyKWqQ8f07fbTPHO/FzH90wDkQ2ef0kajFAx/ukSki51llScIaLCu3ePd1DEqLKdzo7EZkUGydNdoXZObDYzbJuXHKK1fNL5hMsBEOIXgTk9F1zOUCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117004; c=relaxed/simple;
	bh=Ol+EJm8cLxGdf9CbM3fpYT3el5UIktI0aEYJ4EQMVP0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DFkmixKBVPEjXE73aA0RXcc/H+JEPSBNp84c5JGTex1Wk19wwX5bsjkFj4HRuD0jtGTeghURnFx/TKvAynjN4SeOOSCv/RNw/VeKUiOA5KTWsuM7pn0Jtf97RejFPqQwqgIDqSZqARqoysFYp1HStGYIHeTKj0cVYT2z88WPdXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GELGhvkt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2055f630934so39792145ad.1;
        Mon, 23 Sep 2024 11:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727117002; x=1727721802; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2LHmjzXAtMIZmJ5Rn7lQK9rTwNZYqrEZiN8cZ0JMhp8=;
        b=GELGhvktDNocn+eV5BRjpJ5RVtVnnpkgbF6pkw6VXBNnm8Muc2EHBRJy2vGYC/khcO
         00N7Zc7qwbeGJgtZXaGTC5Z8ChDDhzm7UbTUx5fRM3QxZ736ZivdBV7leYoRnA4N5pI7
         CMFqt7UI+7eBsHkQHXwZ4F3/tn+kyHgd2261Ho8ujw9uFxE+hPh1qF0Zi+H9sN8AxsEo
         VInTi9xhdRfYW9egOqDVju/eBjvo/1jbC8ZTysVHyFvJRTLGCJPMiDBaPOAr6dB87EWz
         P4cy+v4iXADxV84qDgv1UhgRHHT7kWQuZ5aYOYs81QM3MNdSakoRDOSGJhX5SklS1c2X
         84NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727117002; x=1727721802;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2LHmjzXAtMIZmJ5Rn7lQK9rTwNZYqrEZiN8cZ0JMhp8=;
        b=l0/ZDnafklYKdNtQ+SLYwbzhhgchzTcIlnN9eH/4tD6vs2W9H5MriPIwtLKBER5CDu
         oDUqlme/M3STQXSsjc0JjtrQSFgmoJl1RTgKlMeqzw5HQh6/1RNLE4V+7v8tpeX4f8gb
         k+YP7Xv4U4IYJnIsfIrBD/q+GQEu08jlPEy20zAGcKlH/KoiS9vjY3bup4t4m/W+E6jl
         hmML0KybOGW2pfJRRFX7O3lFdrbSxhHCNCjpxTSaVvlL766uazqQEqXxKuGo4/zb5OK1
         OV3k5+xhOcw8QcWgbhorzUku1pu9acih/uNQSieMTXbJATDg7XBAvnABatHqsDW1tBx3
         WGZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU72RdwccjKAUBZcoukjGrKMq/4xTB0que1hPLBbLGm80vpBvouOqIm4SFppC6fulQDJD79y6fbVIE+HA==@vger.kernel.org, AJvYcCUFUtzr3vCzfp5hl7J5gbHNCoP5rhnPdvnlXLEFsfOqJKaVXluIqOvwm7MLqQma8Vr6zW7QTSN55ybCzXRhwg==@vger.kernel.org, AJvYcCUtqrbYuWC/BEjAs3EKbnFDwNmVI2mXSF4M9raYw4cvVw4NcRN9lQwBVAqMejikQW/OV/hTAzA233S9HHrZ@vger.kernel.org, AJvYcCVAGD3ini+jVZB5dXTFjIbumYNOK9KYcRHnEboXjRg8jUonmaEggiQ/IM8e3+J4NX2vK3BJxRNP@vger.kernel.org, AJvYcCVmKMKCpjlQHq/M+lgtPukqN6sRmmZE06QpVQ6WY8wq95AabT4rUxcPgAwmJF/wyes+3xPrCg8c/fn2@vger.kernel.org, AJvYcCXumq2oC1gbcbYPaeB7raQc8ZntOzxEFtTa46jUHfF8vytVMyJbV5N3d0oDHk0kzISwYCotpdrm59gi@vger.kernel.org
X-Gm-Message-State: AOJu0YwxoCkVjpE8zAJYoUE39gemieKACN6UYRsd1lE9Pn0mByt7o91a
	NiWwv0KTNWsxftAzgt3VYZd97oois5XTCo30D0glvb3GiZgF/v4q
X-Google-Smtp-Source: AGHT+IHPhZrggldPhDzAISSCt7hDQP+r1zqFPPuYtS+By/R474KzhLZIXK5fLtO4N5rEH3YS+YNQYw==
X-Received: by 2002:a17:902:ecc2:b0:207:3fd0:13ec with SMTP id d9443c01a7336-208d836cef7mr234528045ad.17.1727117002177;
        Mon, 23 Sep 2024 11:43:22 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794601008sm135317725ad.81.2024.09.23.11.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 11:43:21 -0700 (PDT)
Message-ID: <670794146059f85a30efd7cf9d6650375d987077.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: Manu Bretelle <chantr4@gmail.com>, dhowells@redhat.com
Cc: asmadeus@codewreck.org, ceph-devel@vger.kernel.org,
 christian@brauner.io,  ericvh@kernel.org, hsiangkao@linux.alibaba.com,
 idryomov@gmail.com,  jlayton@kernel.org, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org,  linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org,  marc.dionne@auristor.com,
 netdev@vger.kernel.org, netfs@lists.linux.dev,  pc@manguebit.com,
 smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
 v9fs@lists.linux.dev, willy@infradead.org
Date: Mon, 23 Sep 2024 11:43:16 -0700
In-Reply-To: <20240923183432.1876750-1-chantr4@gmail.com>
References: <20240814203850.2240469-20-dhowells@redhat.com>
	 <20240923183432.1876750-1-chantr4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-23 at 11:34 -0700, Manu Bretelle wrote:

[...]

> The qemu command invoked by vmtest is:
>=20
> qemu-system-x86_64 "-nodefaults" "-display" "none" "-serial" "mon:stdio" =
\
>   "-enable-kvm" "-cpu" "host" "-qmp" "unix:/tmp/qmp-971717.sock,server=3D=
on,wait=3Doff" \
>   "-chardev" "socket,path=3D/tmp/qga-888301.sock,server=3Don,wait=3Doff,i=
d=3Dqga0" \
>   "-device" "virtio-serial" \
>   "-device" "virtserialport,chardev=3Dqga0,name=3Dorg.qemu.guest_agent.0"=
 \
>   "--device" "virtio-serial" \
>   "-chardev" "socket,path=3D/tmp/cmdout-508724.sock,server=3Don,wait=3Dof=
f,id=3Dcmdout" \
>   "--device" "virtserialport,chardev=3Dcmdout,name=3Dorg.qemu.virtio_seri=
al.0" \
>   "-virtfs" "local,id=3Droot,path=3D/,mount_tag=3D/dev/root,security_mode=
l=3Dnone,multidevs=3Dremap" \
>   "-kernel" "/data/users/chantra/linux/arch/x86/boot/bzImage" \
>   "-no-reboot" "-append" "rootfstype=3D9p rootflags=3Dtrans=3Dvirtio,cach=
e=3Dmmap,msize=3D1048576 rw earlyprintk=3Dserial,0,115200 printk.devkmsg=3D=
on console=3D0,115200 loglevel=3D7 raid=3Dnoautodetect init=3D/tmp/vmtest-i=
nit4PdCA.sh panic=3D-1" \
>   "-virtfs" "local,id=3Dshared,path=3D/data/users/chantra/linux,mount_tag=
=3Dvmtest-shared,security_model=3Dnone,multidevs=3Dremap" \
>   "-smp" "2" "-m" "4G"

fwiw: removing "cache=3Dmmap" from "rootflags" allows VM to boot and run te=
sts.


