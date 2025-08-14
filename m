Return-Path: <linux-fsdevel+bounces-57955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFF0B26F9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 21:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1A01882022
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 19:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B53923AB87;
	Thu, 14 Aug 2025 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Sk+EMZw3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C181A8F6D
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755199169; cv=none; b=X1q0QQacVe/82HiPMdkMX39nc6ahp9RGMD1ynnRcRKj5kQzR6VSh30yZuU9NpLXdI6CyM7eYqFjum2Z178SKvrJQzRvy9lg33WzHmIzgYGJHPABqMQHFnowPJsgVrWDLrURbgQ87y/jn7PBxbvNvxVi/QiP3gtzjkhA3CAiQpuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755199169; c=relaxed/simple;
	bh=GZrMOqecm9CAXjRBdYJgjbJgjQE37LwuoMcleOFOzN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cD8LGi/C8mZxZEVaMBjvuIzXj04MkWyn1d1zTcJXTUprcR1GcMsnKO12uA/2oSa+qNLfsIqIvIQ/XzWLDU7saxMfurjUfCa9hhfvX/vNqrqDPAY9UxcNDV7zziXgHqPsFg2QH7IMUHDL3N4P8KSQZAVtNk55iNpTUEfZcPnuobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Sk+EMZw3; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b1098f9e9eso17518551cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755199167; x=1755803967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GZrMOqecm9CAXjRBdYJgjbJgjQE37LwuoMcleOFOzN0=;
        b=Sk+EMZw3gtt1Kc+KQUk0IjMhmiwSweTjX3U0sQuDlp01ImsScESjG7DfPaSp7gQ0xB
         jnSDNwCcV+5rVjAkep/QGQNNXtX619jD9ntUjcq3Vgq3o/gwXuciuUtwSTUJ+yCGU+d+
         650qXU+NziDKW25fY+3FsI4l3NEXHsD6y8rtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755199167; x=1755803967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZrMOqecm9CAXjRBdYJgjbJgjQE37LwuoMcleOFOzN0=;
        b=Fy0U1l2e/dCLhLWFE/AJg2rgp943SDBjwwY4CowRnH+eEQT2tHEJer9ZB3xr8MdcDa
         6r+qUfdkd3UvO5RiSbf3cPnTpUnIxs5rfpEBWvGxN8k1SIPHAvwcEKHZxP7PtPUwKL7q
         frjq929tLCl3H3B9OcS3xb02HHYkXagwW5Hv1rjrZCV7EoWOsVT5zPPb6gAhYITAlXx7
         10iOacroFDEcqp0c6KfpBarYNaz0FzPHFuJE94QaxIGPEXJwLWPIke7DaNj95Epnex0a
         3P3W4sBPoa+Cfez/+6sOMKfygTcsZjB1+eyP0AToxXlR3NSgTrrZagMLVWbGMlOiPppC
         NmqA==
X-Forwarded-Encrypted: i=1; AJvYcCV3SE7k5fZRg55e/qKoVRruT0ThYhXc+Q6B1yjoBGmZ4jgMZpnTzKjgemDsxM6P6mdCGl/6Le9cIehph8Hn@vger.kernel.org
X-Gm-Message-State: AOJu0YwiSvOCdhCPB4sBgAJ34zMtn/03K/5dlj07d9i20dPmIqCsfBCl
	2QADpVGsWyBHgEJ/3wWDV0FyIv/gTc0vPvBImuE53SlYvl/v/ECLOZ0o3Dxaj7WTwU/SoKtPcci
	I0+vtETKfsWy/HA/LW0t4x+IyNjlDvUCiMNLEs8vC/w==
X-Gm-Gg: ASbGncsYomjoHV1VTu++0SdCDCOhaK0Dv5MkHnQ+tadBCGerChkKSRIRl85a8nkaRDz
	LDwi2b0QbGgUEOLnLyq43ZrW08JtV+7sznbovgh0tidAhUxtIgK4J6A5g9C2VWnVi+dware75F/
	xbHqv+aLBGcsZ8g3RsVsbrBarL2Aao5qNBuEpR+eVZEX97xIsUNWFc2Gvzf3rpDS+ZBzFAgpcIz
	BoAkWsonsf/y7M=
X-Google-Smtp-Source: AGHT+IFYsASkbgj8LKOURL/sQT2BfijqH2fGAl8jogtfvvYUVEiGcWyswxRpTwKUf9rW7ApmSBhJ6Ltm7fsi8IzNXrY=
X-Received: by 2002:ac8:7d43:0:b0:4af:157e:3823 with SMTP id
 d75a77b69052e-4b10ab61354mr68262251cf.42.1755199166768; Thu, 14 Aug 2025
 12:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-15-john@groves.net>
 <CAJfpegv19wFrT0QFkwFrKbc6KXmktt0Ba2Lq9fZoihA=eb8muA@mail.gmail.com>
 <20250814171941.GU7942@frogsfrogsfrogs> <CAJfpegv8Ta+w4CTb7gvYUTx3kka1-pxcWX_ik=17wteU9XBT1g@mail.gmail.com>
 <20250814185503.GZ7942@frogsfrogsfrogs>
In-Reply-To: <20250814185503.GZ7942@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 21:19:15 +0200
X-Gm-Features: Ac12FXwFvJoOQXfTVyVQkORoWxApgAqsvX9WIX8VNMR4nJ4kVqHzj7yLc5euRJ4
Message-ID: <CAJfpeguxZVVddGQsMtM35tVo0dD118hKBf9KJcuhSBznzqUzSg@mail.gmail.com>
Subject: Re: [RFC V2 14/18] famfs_fuse: GET_DAXDEV message and daxdev_table
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025 at 20:55, Darrick J. Wong <djwong@kernel.org> wrote:

> Or do we move the backing_files_map out of CONFIG_FUSE_PASSTHROUGH and
> then let fuse-iomap/famfs extract the block/dax device from that?
> Then the backing_id/device cookie would be the same across a fuse mount.

Yes.

Thanks,
Miklos

