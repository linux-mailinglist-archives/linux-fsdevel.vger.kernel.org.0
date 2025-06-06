Return-Path: <linux-fsdevel+bounces-50865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5948AD0886
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 21:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A4C3B3ED2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 19:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5E21EA7C4;
	Fri,  6 Jun 2025 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="DkA7DbxK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0556A8D2
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749237332; cv=none; b=rJSlHEuEyEf8xIfKvzWctbOjM3ZLbtIyZnC97nwhsmIU2OOMSSbt7JMSwz+/rtGqNoY4cPvtu4EQWch6/B9NZxfZb1nZfPLSYIEXZKvMjk88BWqm2zbvROqlFxvr8kwpuXPkDSMl+PBdFN5ksUWPpRCg3ugd7KDXB7Phua10i+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749237332; c=relaxed/simple;
	bh=GPyJpQ0MM3+sCyiRNE8U4gRHQyAm8DS7ZnG7aizdKZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5a7W59RmASul9ZDckQLVS3m+hIOwdNIew3nrg5PO0o8kYEdZeccgfyIzFTMnu78ESr1gRHj3jL7FaXpqo09EopYkreDYvJy3/O3ng4ak7h11Ax+ryROkx8WUHIOVnmZYCzXdIKqwUd7THnYMzGajqapwZ7w6TFj+zgWhiX8lO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=DkA7DbxK; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556JFPYg020032
	for <linux-fsdevel@vger.kernel.org>; Fri, 6 Jun 2025 15:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=hxKpvIwDJev2AQJKrOOsefY7R3fXf+i39zjL9smzWlg=;
 b=DkA7DbxKWkuSHI4iA1MT142Cpjb6/8TlBCIIakYVq0CquCP/OsqASktksi65uhVS3R0K
 pYAf0AWDlurGLVY0A7dax6S2OkNvYHys/MxWBNvZt5WywemKs+i2cp9KKyyX57XalUIB
 Z1wbzFseZeI904Snaxa0hDVP8qvYuw1r5I16/pG/SBkvCw0JxaURlW15Vmbafv8xFP9L
 aowr3D/GGER2+HZChR4zQDlQ5/fF8cCKxYAxA7ziPaETHJyOJZx+ckqWd+YNunLjeg6g
 LcvHQ8FAnOnAsP8auXLJCNtclMht8N8djMRGW4Ws17QR+WWlgUqS6xiy0vg9Tkz+yh9T oQ== 
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 471fu8mga5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 15:15:29 -0400
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-70e735c7857so31559207b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 12:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749237328; x=1749842128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxKpvIwDJev2AQJKrOOsefY7R3fXf+i39zjL9smzWlg=;
        b=QroBKjNGtemyZcf1CON2gY8SnF21Ii5FQCIX9vfj+R/VYos2iMjJ3/rjm7Fc1E6079
         m2SuYW2VfEdR9Wwu6Y3G4wXPrWFAKU7/T72FSwwSylYjSIf6uyr5c+SfMd1GFPs1JTnh
         uOQrFGmuo8W55BpY9EICYMPgfwuhREWdamp4V+4uyAHL3lDcd6ZdQC4wtuS12WlAx50l
         WZklChcWw5T3uHlsQDKfxQq8Lj/qz1J00sGtryXl9xDAgFkUDaZmFe1qwhy1FK05iLPY
         6xAbrpgmJLhaWSgbCm6CK8fSKTDF0ixkRAPcbIYYFUL6s5JdsdVTXMK62YVF9pV+P/Dt
         Y1LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC6CIUsT26okRgtJnUf6uzN0HLHH/2zy9/nuoZv0V2n13lF6N5Xmlz/2Ivk73t0L4vw3XbZ6BV06gLbh/q@vger.kernel.org
X-Gm-Message-State: AOJu0YyiMZEJnKOiu01XeHmr0Sdseve+4qVIiHEDTA5340HD+v0o2imJ
	ieD+lsvvOVM5xf/gI6pbn550zgOHij6in9Yv0mAF6we0vdS4GGRgrk3GfeaqAj3hH1419uVHepl
	dmowL2sPMemagf1kp/DJblpzdDUXlfQvr+sO/3SByN7HolU06SOMSkUVzlsSIUGuYhuZPutD6/I
	tfg2BBrh05ubg6Ic6inhq47zzGwhz1dfuQ09WdaA==
X-Gm-Gg: ASbGncuDKU8PT9+fTUdyq+8FBzJrlEAwZKQwOMkItLFVpq+v12c7Lkd49iSP91n+j4Z
	pI7x0IzMw200VjO6Kz7kEB+NO7B+v93u56+P90sUkIOwWxBN1WjIULjE5q0ukrEm8qjjC+A==
X-Received: by 2002:a05:690c:360e:b0:70d:f3bb:a731 with SMTP id 00721157ae682-710f76949a7mr61381297b3.9.1749237328275;
        Fri, 06 Jun 2025 12:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmh5c+UyPtFHTyhFmv9SKnRfaGxEIhGfyJzFKAkpNJdzUL5OS8y0tgPWOcR4UTikcCpHWRgcH8NmKHKIpVeQg=
X-Received: by 2002:a05:690c:360e:b0:70d:f3bb:a731 with SMTP id
 00721157ae682-710f76949a7mr61380767b3.9.1749237327889; Fri, 06 Jun 2025
 12:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
 <20250603-uffd-fixes-v1-2-9c638c73f047@columbia.edu> <84cf5418-42e9-4ec5-bd87-17ba91995c47@redhat.com>
 <aEBhqz1UgpP8d9hG@x1.local> <CAKha_sqFV_0TsM1NgwtYYY0=ouDjkO7OOZc2WsR0X5hK5AUOJA@mail.gmail.com>
 <aELsIq2uOT5d1Tng@x1.local>
In-Reply-To: <aELsIq2uOT5d1Tng@x1.local>
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 6 Jun 2025 15:15:17 -0400
X-Gm-Features: AX0GCFv-LebVJckbZYYmiOxBhz5geAlpM1m_LD3eRjbOgJZYzDANJjo8J0v__W4
Message-ID: <CAKha_sqRAW7AmZURC7f7hkja9XRxPkccMB17Gay5p8Qm+cojuQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] userfaultfd: prevent unregistering VMAs through a
 different userfaultfd
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: V42HNfBgYHyOESq79symZefzCtKV0Uzu
X-Proofpoint-ORIG-GUID: V42HNfBgYHyOESq79symZefzCtKV0Uzu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE2NiBTYWx0ZWRfX+PzytgdjdQRb WCBhGQndrOgT1OqYlk6AsGbkt+cMrOgW/frYM807Z+ybEgZ4lpK7JQiDnps2YmEQi9I6zNk/Xh1 Bpd8C9mYk79o5+S8Sw9c4Vy6mF2iYlWXWdkerIREPJQ9oJkgQwTn3knIR7dS1BRwKemoAvjjDue
 Lr5glRTMXhhumGf38LdIoqefXMC4ihXcB8MdfdK/ZTanfgDv7jmXSJqSG9HQDaHp5GdJcLgHVbG 3BlvNOZUh/tmr2HMglg8U7a9Wc+UMIy2WxrR+LxYYXjsfR0Un8mhV7dewzrOahzhdQLd2ddzQgb HOa6lY8OnuAUXVqv3r0vjvPgAy9IOETdFze8oA8gedpHHU3W+Sg7Zxm7YEar4G91a5oX4l68Tr8 SObmC2Nb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_07,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=10
 mlxscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=725
 phishscore=0 lowpriorityscore=10 priorityscore=1501 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506060166

On Fri, Jun 6, 2025 at 9:25=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
> On Thu, Jun 05, 2025 at 05:11:53PM -0400, Tal Zussman wrote:
> >
> > As I mentioned in my response to James, it seems like the existing beha=
vior
> > is broken as well, due to the following in in userfaultfd_unregister():
> >
> >     if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
> >             goto out_unlock;
> >
> > where wp_async is derived from ctx, not cur.
> >
> > Pasting here:
> >
> > This also seems to indicate that the current behavior is broken and may=
 reject
> > unregistering some VMAs incorrectly. For example, a file-backed VMA reg=
istered
> > with `wp_async` and UFFD_WP cannot be unregistered through a VMA that d=
oes not
> > have `wp_async` set.
>
> This is true.  Meanwhile it seems untrivial to fix the flag alone with th=
e
> prior per-vma loop to check compatibility.  We could drop the prior check
> but then it slightly breaks the abi in another way..
>
> Then let's go with the change to see our luck.
>
> Could you mention more things when repost in the commit log?  (1) wp_asyn=
c
> bug, (2) explicitly mention that this is a slight ABI change, and (3) not
> needed to backport to stable.

Will do!

> Thanks,
>
> --
> Peter Xu
>

