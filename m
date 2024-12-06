Return-Path: <linux-fsdevel+bounces-36678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA329E7A39
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 21:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AEC2818D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 20:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999AB204590;
	Fri,  6 Dec 2024 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9Ol+2OJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2881F3D51
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733518215; cv=none; b=gX1t7uRw8+d/mur2TNc0gVSyFY0MXJV7xGoalbF0ydJiBzuOwxkmJpefq3NhQpuM/rJfKhTjRh4uXuRbSpBT+8bkulPekDt5qUBKeVo03Csyu8d1+8tG7oLsb275sChljYpVyfw9GlnFLFKfADgPMDUFirXFZASonvoek24bJRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733518215; c=relaxed/simple;
	bh=lG6UScKygXE0DZKpjusrU5YBmeakALe/kqRQf0bpyjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mI5Nzo41o6JsAmxGsUZbc0rAUcYCv1ttedt492RFTcBBpScPnf5+4n12+3KDUAqEcMsPlTZW6GvsDs487Jc8HylY97qvrI5vEDfNcS5jVCP5Bm2wb7oDLnqKW7IPFp7T1HkcdgvUDIOKX/hvrhwNQ74wlBojQKhud2UuniytUdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y9Ol+2OJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21625b4f978so28725ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 12:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733518213; x=1734123013; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kIQnC6QifSuf9C4/nsTfcLNSPKAxynKHyi8fol7mDZo=;
        b=Y9Ol+2OJ2QZh5Zy4t++b5RtRb4iOzzf3Svy8TMnJjUVYO4yZ3hh6q/gtKAXl1qEzqc
         GCSMjNHK3MVIPE+62AxyuAqKh/sqZ1ma1tq8xzwnUdfnXdBAlfjWkaYVDu1he+Cld46E
         v3k5fo7SD4KlcuSTglTwAnWfSrwy1FPhUdGj+XwXw3jwN0uE+PteNbRnULs6Ebt0F8nr
         hF92tP+q9RhLDudJEDynWQ60rNxFpK9kEoSKqf1wr0+gHtPvrA00G/wvCKodvY26v56/
         gDo5mmcWVx/6anARekCQXD9o1qAL0QC8F6vYM/2SKXvXvbaeISE4xpZEgpqKIZ7Z64Ru
         tsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733518213; x=1734123013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIQnC6QifSuf9C4/nsTfcLNSPKAxynKHyi8fol7mDZo=;
        b=AqhrP1emGlDk6tb8wBKHIL7rEn20BU5GfbPg+yqBsuAysY9yIi167oRZbDeJ011hwD
         3dLEBOgqBvVKwhV2tTpRUNbIjocQUV10QP4ShZE9LXj+UCNR6Feb9Y04barlPvY6cpKm
         3cLxatwDGM05Y1GJ6R8Z+dliamCw7N7/cwF7a1SIsayt9JoxjHeLSlxrb2bMNWuY6Cur
         OPJNPFr5L1s5RtPSRR1XQ4Dm/E5wwWMr00AskOVeUhXqHlxhrPkJrpRvQGgW28/RYm3p
         A2Jiyg33PdruPX4Re62teVIvaedHols/rCITR3GnkXp1vyFjRcbvhe/zGTzI+nx16mYO
         Olcg==
X-Forwarded-Encrypted: i=1; AJvYcCXRDschJxLm7Ax+99fgq4fnyKrwksGUZqC2wBE5b+70vNnhYhdYo8zM5nVcIWs6c0qkR4qADsP/xC31Iga5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm5EzpEdEMop1DNrhHN7XE/JvDtVEqbCOJANuvq9FDmHfwBZNM
	39rOsrHxkamb5Mi3SkVCwLMsoFAHXXwuCnS/sff51YEnHNC3Qv7z6gpvx5GElA==
X-Gm-Gg: ASbGncv70S+dqaoQZICqy/36X1KhJY07MyUm0iQ3UBjUwpajsyhn+cuNdB51vEW7s5R
	Tg3ZjGL123a8ywDyqUFTu4AGYz/sEK/d83a57KfRCZe8RAGXdBda2cHFQIFiKD9/3yEu3i760Yw
	FSKzDXDglY6zbI2+AWpEUHE3F89K0Tsx4NSHNvTUNyQdMCOBwbmIvJRBCEnihg0/fvwM9v8LgHC
	rRm3LDGW/sZfJXh+bOafBX24T8GErvc+w4iaaqxBaS7vvTPsw==
X-Google-Smtp-Source: AGHT+IE11QsSYdu5EzfTjQLwDvWU8Ay7LIt+L9MNUYsryjf+ALBnUiR7v52/e5aef5B1j//XzPS0RA==
X-Received: by 2002:a17:903:174d:b0:215:a3e9:88cc with SMTP id d9443c01a7336-2162ad6a09emr331635ad.3.1733518212757;
        Fri, 06 Dec 2024 12:50:12 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:7caa:6c4:e72a:a87d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162c062f40sm35715ad.90.2024.12.06.12.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 12:50:12 -0800 (PST)
Date: Fri, 6 Dec 2024 12:50:08 -0800
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Shuah Khan <shuah@kernel.org>, kernel-team@android.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	John Stultz <jstultz@google.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
Message-ID: <Z1NjgK2wSUdeM525@google.com>
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com>
 <CAC_TJvdVhGW+4y0JHqRVTdqAWpQRDOgWW8b1TAK3V9zdnmw0ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_TJvdVhGW+4y0JHqRVTdqAWpQRDOgWW8b1TAK3V9zdnmw0ow@mail.gmail.com>

On Fri, Dec 06, 2024 at 09:49:35AM -0800, Kalesh Singh wrote:
> On Thu, Dec 5, 2024 at 5:09 PM Isaac J. Manjarres
> <isaacmanjarres@google.com> wrote:
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -375,6 +375,17 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> >                 if (!file_mmap_ok(file, inode, pgoff, len))
> >                         return -EOVERFLOW;
> >
> > +               if (is_exec_sealed(seals)) {
> > +                       /* No new executable mappings if the file is exec sealed. */
> > +                       if (prot & PROT_EXEC)
> > +                               return -EACCES;
> 
> I think this should be -EPERM to be consistent with seal_check_write()
> and mmap(2) man page:
> 
> " EPERM The operation was prevented by a file seal; see fcntl(2)."
> 
> Thanks,
> Kalesh
> 

Thanks for catching that Kalesh! I agree and will fix this in v2 of the
series.

Thanks,
Isaac

