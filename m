Return-Path: <linux-fsdevel+bounces-62028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4AFB81EDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB711894741
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E53302159;
	Wed, 17 Sep 2025 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcQgbOt4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE6231A30
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144046; cv=none; b=mDmQES6Zk5pML9if39ZO1FSFR2ThC5rF6q8B8t7zVwNvYTv3pThZ+1Avs4St0Np9TM8IY2EJvkkK13z/VFuH3yX6Inhvb/qHoV+6RetNaPPA12Ts+oNqACe7N+QJqrvcR4rI+gGz9cADrYe42ewftt1sVURqbjsp1fDBuiq63Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144046; c=relaxed/simple;
	bh=Jr7tOhVNmdopvbm1sq/HNYW2sZzQ2S6zGCTPL3CWNug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p69w/UY/lNRr1cnPO3vXgql/B0Br7T/LEyDG6McNMsthm/RbmIPPGAkbYhXxx+6v78VSr1pgRn50Yh5vsHKfccY3vTozfr8DXCOEG1/3ZlgtcUqrLEIoOFhHXrQlhAOsPRYRjXuCEHb1ovR+grjhHebeNFxxXich0oW0WUpoTIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcQgbOt4; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62f799a5b72so413215a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758144043; x=1758748843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qm04iO7/3sYnnmFBSTq3Jy38SggYiX1vAG/ti9DkIJ8=;
        b=RcQgbOt4lTo/tMBQB/CZS1bMg/5QbiabDAVtWYoM6jOZM2syjql4x6o5Op6oFjZsVx
         u/tx9EVOW6uywVPTQPZV7wrYvGMS8ZozcHFEq6ZSDUojv3+UPmkf/ajmibbEZkPV8TLe
         TtdonGylex26e78pDhnT+24/Z+1HS4ywAh2qNKaiHXzo1MBtdfhhuIkdYsavx6n9lSk+
         SJ40FUN9LaK2/pLd3MoHcqiKF8eiQlLnrjsU+dJBc61QKyuA1bP2gI58G5puEmz0XGNp
         zNqX2ip2pWjDB+ZsYBxy35XuXdcjZK22bIC0/umW0b/Sy5S11+IZr7vZLaF1u9alZfdL
         L/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758144043; x=1758748843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qm04iO7/3sYnnmFBSTq3Jy38SggYiX1vAG/ti9DkIJ8=;
        b=oVMUAPAFFzMCIqstolQNEoVgDAGVAKC5+o7waOdOqqsi4S2TAaX+UXdxZzwey5tg79
         CW8z2bSxrOt/DVPI4MDW5Q3k4YYwu7fyHLHg5r3t8JsmS71ehxY3n28mUZKEdv5RvU56
         LpaRbg6YQb6BspfCT93/d+oXPhxtXjABRylHSdAPQRj4vN7cYuuhw7Wojyue67G6AWoH
         pz3xm425IIwymibkp2cmtm4YuNmgEoUKmuec5X7fAoa2e3XA4kYEN7SYsfLW6Gq7SYjQ
         5C9PlhCzzbGlxnK0pDOLuTw0zq/dYZkjNMJi8A/8tKIlll6UWCGREpf63sdrI27sniaW
         4dXg==
X-Forwarded-Encrypted: i=1; AJvYcCUTYs9QaPZyyA4ttjbyHEN9W3oBJkRHOnbsE9iO6thuMtqGGb7UNhOuw+EZhNhn+QrlV7mVRom7hrspN2dR@vger.kernel.org
X-Gm-Message-State: AOJu0YwFZsCY0gOxuX6pBIVfi1KxVViedaCC/HqvExxSvf/jUTwOKsfu
	Oz7D9Ce0fNv33NQBoJMsRn4L4hnr6siaLXOIp5+4YL5kMPKL/pV7oWPDIuiD9nw9lxw/RiwBgKd
	4wqcov2aWOa0eZs9VQ71TcmmGQ4RgRKar0839
X-Gm-Gg: ASbGnctxYivcHtnU37wvDuhazSxGtJ5dHoN0FY7IAVSjW/ZF/qY+qtt9m3158gwawpZ
	lRRG6ihowOW2QUdmAW03mOwBQSs4lEu5Jvhs7ZaI4T297WvuyPg11odI6xf9SIvX85QKaKjT937
	m4NdB9qssm1JekwoNOgOoBG3Kloel65x6Jd6Kk1rMblnxHTazdeaqH36dEZqfFS7BPf65+AtjTE
	pw+VS/RbrhTH8Wa7NLceLICDJHIBD81bV4e6j5HLTfZp9FL455mli8ehA==
X-Google-Smtp-Source: AGHT+IHUs74RiuzMxtMB/SJNv66S3T8Y+4J7/v/JeOClSkPet/FUx/BcGD0yy1WcahJITTBzZkWaZvd3zcPgO7Lq5J0=
X-Received: by 2002:a05:6402:5211:b0:629:3f9d:b06c with SMTP id
 4fb4d7f45d1cf-62f84444eb5mr3183454a12.33.1758144043263; Wed, 17 Sep 2025
 14:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+-QRTC_j15=Cc4YeU3TAcpQCrFWmBZcNxfnw1LndVzASg@mail.gmail.com>
 <4z3imll6zbzwqcyfl225xn3rc4mev6ppjnx5itmvznj2yormug@utk6twdablj3>
 <CAKPOu+--m8eppmF5+fofG=AKAMu5K_meF44UH4XiL8V3_X_rJg@mail.gmail.com>
 <CAGudoHEqNYWMqDiogc9Q_s9QMQHB6Rm_1dUzcC7B0GFBrqS=1g@mail.gmail.com>
 <20250917201408.GX39973@ZenIV> <CAGudoHFEE4nS_cWuc3xjmP=OaQSXMCg0eBrKCBHc3tf104er3A@mail.gmail.com>
 <20250917203435.GA39973@ZenIV> <CAKPOu+8wLezQY05ZLSd4P2OySe7qqE7CTHzYG6pobpt=xV--Jg@mail.gmail.com>
 <20250917211009.GE39973@ZenIV> <CAKPOu+-yOH6yzPEw1rayR1thO0OdPYCRL-CWkRTp9YFuHuRr9A@mail.gmail.com>
In-Reply-To: <CAKPOu+-yOH6yzPEw1rayR1thO0OdPYCRL-CWkRTp9YFuHuRr9A@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 23:20:31 +0200
X-Gm-Features: AS18NWD_v5OF_xdeJXUDk_UQNpV1LRyG_6pKAZAV2UR008iFDMbWoAW5oKUSiLo
Message-ID: <CAGudoHFdbmrLfLNKRb4cauzHOPBDqQT1zJ4xYCLXW5RJViwmZA@mail.gmail.com>
Subject: Re: Need advice with iput() deadlock during writeback
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:19=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> On Wed, Sep 17, 2025 at 11:10=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk=
> wrote:
> > > Each filesystem (struct ceph_fs_client) has its own inode_wq.
> >
> > Yes, but
> >          if (llist_add(&ci->async_llist, &delayed_ceph_iput_list))
> >                  schedule_delayed_work(&delayed_ceph_iput_work, 1);
> > won't have anything to do with that.
>
> Mateusz did not mention that the list must be flushed on umount, but
> that's what "incomplete sketch" means.
>
> (The patch I submitted uses inode_wq, but that's a different thread.)

I assumed someone would flush it to speed up the unmount.

I fully admit I did not realize it was a correctness issue here (see
my other mail).

