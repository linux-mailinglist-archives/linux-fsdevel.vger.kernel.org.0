Return-Path: <linux-fsdevel+bounces-18376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6888B7BFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 17:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2307283000
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 15:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3CA173359;
	Tue, 30 Apr 2024 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX4MpSTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541D770F5;
	Tue, 30 Apr 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491663; cv=none; b=Xluunrp/E/DpeQA1O+SPCBU5Xh1lsEiIDj4o8tTChSyP8Ngl92QCIjMk+PzTsOcMXTCOfhGk50QXbC2kWZbW+di+337dhRhnrYGf3lntSYJi62gO6NJIwqf0wmZ+A7zpBZuH6BHZjhDTOBPeKig1WS13IjTWXJKP/kjRFsu+Veo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491663; c=relaxed/simple;
	bh=f6IqcFeBOCpWpa4vG7S+dRgb7PQm2Hc82dX1ztXa+5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6XP3/yLXMEQSAw2Co8VjSKN18BYcqb6CnFjAeBRufcPKINySHtF6tX5sx9Gjv3gZJC6qoSgeciNyiEhEC9N9lnEgWES/ySbGrYf5Bf8p4aZtEDn6ix/QCmAkpAE9oupYQomoWswlV2QKgGcy4n4OzrgrbHKmYUtSCiJJFd6w3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX4MpSTm; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e10b6e2bacso7408371fa.0;
        Tue, 30 Apr 2024 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714491660; x=1715096460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HktqAitX/MFbl8Jl2t5m5ekVWv2NVSNp30OIaNycsOg=;
        b=YX4MpSTmm/b3Up98/2cWLzaS4hN1qZ8tdHqTr6Sr9Ii/E7JlA2jWYCi5kvsOWbQS0F
         LUvSiZgrGWuOpEF4VDzrjHjedlENPtxCUOE6QsTPr8ian2MG/yK3CPCXPsCcnH+9AlN5
         dKwEMU/rVrKSc58V7zcYftF9MGJZMhikxCwBRkUfXDGUtxzCvKnKAFnN0ZJXxFAqu08e
         J8t5NfAMszcRqS5hyXYMBjToEG3dGS7+q7v9eYsQNOF/vuWNtPLGhwTLTL20pLqmYNHc
         bjEu7+azmmDRVFiDUHiYnGZyzQXwbdLqZsz8yeZDfyYhNKhIJlTmKk90SI1ZDNfSIb0o
         a4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714491660; x=1715096460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HktqAitX/MFbl8Jl2t5m5ekVWv2NVSNp30OIaNycsOg=;
        b=oOemjloDRRM8THokoAC+/GtT4fMhQ+A7Escz4Cr9MZ9Z1K2mgZccW+csQ2t3Phry2W
         0oCdioaWpVqQJX8opj96HKJeF9ztZGmJfTfwQBV+wcftjj8HnQFrQBrzKyfQ0gt2ikTL
         BqPrvCKi90jM1L0q3S3Ar1w1S7RahghzhZ4EerWyw1bmy0/OSLaMww/j8XZUWXA45PN2
         bCDa2BpJik5oQ9nhGhfwZnqunCXa75V4lzk1nd/mSYqfq/87vwMUupHnxo5oOKhGMkG0
         w4L9HIbh1XWquFuhtSmdc/CKdWCsop41qm4/Gk/klL3BEdlWv6zTlLgoann0yMm2Shck
         sKEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxyy1852J9oPrygDB1OkEtos/4YBdRQre+Z9n7y9aUVfnuwKGoWiLMvavu/m9OflfRUtESf+/pAAHP6wgQtaO3nNRBpGCSeM33mAuTBeGSFe3DiP77YzmQXjEy6KoSaaTkKdVYiLtP/RviRw==
X-Gm-Message-State: AOJu0Yy2yghjOMuytJ7YRQHMlLETlAOnZiLJwWJSRoaWyjbA4G4tlfNA
	DZmPZ22JF/3/1DNUMKPZrQaKzRNwYGb5AZ++50b/muO40pDJNLrXwmn9mIf1U7ngcEMcla+TBIu
	sRsOwvhenklyaKLm1dfhLf3IUJDg=
X-Google-Smtp-Source: AGHT+IG8HZi5mm/vVlVqKzeYyGwgwHQuIG8Dud5BOqVzlJHHrAvxS6dc1LaLoIjZ8FytpPc1dV7Iv1vI9mO9znyrWMQ=
X-Received: by 2002:a2e:b747:0:b0:2e0:4cbb:858a with SMTP id
 k7-20020a2eb747000000b002e04cbb858amr39154ljo.27.1714491660173; Tue, 30 Apr
 2024 08:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429190500.30979-1-ryncsn@gmail.com> <20240429190500.30979-6-ryncsn@gmail.com>
 <SA0PR21MB1898817BA920C2A45660DE65E41B2@SA0PR21MB1898.namprd21.prod.outlook.com>
In-Reply-To: <SA0PR21MB1898817BA920C2A45660DE65E41B2@SA0PR21MB1898.namprd21.prod.outlook.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 30 Apr 2024 23:40:43 +0800
Message-ID: <CAMgjq7ADnn+uEL0jY676rk6+9cFWgrZxMCZ2m2qf1GM87Eav9Q@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v3 05/12] cifs: drop usage of page_file_offset
To: Steven French <Steven.French@microsoft.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>, Shyam Prasad <Shyam.Prasad@microsoft.com>, 
	Bharath S M <bharathsm@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:19=E2=80=AFAM Steven French
<Steven.French@microsoft.com> wrote:
>
> Wouldn't this make it harder to fix the regression when swap file support=
 was temporarily removed from cifs.ko (due to the folio migration)?   I was=
 hoping to come back to fixing swapfile support for cifs.ko in 6.10-rc (whi=
ch used to pass the various xfstests for this but code got removed with fol=
ios/netfs changes).
>

Hi Steven,

I think this won't cause any trouble for that, the new swap_rw
interface should have splitted the swap cache from fs side, which made
the code struct cleaner, and I think that's the right path. NFS is
using that already. With this interface, .read_folio (cifs_read_folio)
should never be called for swap cache folios.

