Return-Path: <linux-fsdevel+bounces-67932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2935FC4E385
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96FA44E9E7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 13:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7212B34250D;
	Tue, 11 Nov 2025 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iVR2yBi+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE72B331235
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868694; cv=none; b=BjNp2R5LlFQFJCWc4zRQP79TTNzdhm2dxEnJ+Vq1ZNV/k83CGgski9oPcutxpq3tcGLDERkusaK1f7XaeU3Tv5rYoy5A3oDcUvzcgTjK1DnfwXTJdDjZs+w5T2VoBHRPe0OuuklQDjLx2mslKPWIZS/sNJgnhycVKHsDFJKTsXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868694; c=relaxed/simple;
	bh=BNOzgUYOcnJc6jUkH0FdQt5N0+21shSFRmdxMj09ooM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYf+cQBZDzvK5rkbXgGvCxIh2Bcb/ndJS4JCsKZF4PsTNpxFSMPH+dJCdug+V42wlmDEMrwZobdv2aeWqmkUzzSfTwCG5WyYOPGmaZrhOEepoNMzNVhQuUQzVCDPcDgwtYv3llkrw9Jh8PUVH6BJFRUh05fjbk266i4kxM5+VbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=iVR2yBi+; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ed72cc09ddso22404511cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 05:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1762868692; x=1763473492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p5k10nsHfVcysSEr6r8VgK9nyddtwoeg+8UBvBlu+UM=;
        b=iVR2yBi+p0/CxxmjW8z/R7YLCC3cfo1vUTqFNr5IWDLXMh68VqfXsbfsOh6uHElp79
         6ZsoU5Pov9DYmffEf5+OcnabUCqsGuAZhMuJlQZyI+DVVcnbhxMS8r+ci2F1pbPXPLsV
         kYSM8PgPR0IjhZ6g7Dhi3C4MvWIbD77nyA3yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868692; x=1763473492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5k10nsHfVcysSEr6r8VgK9nyddtwoeg+8UBvBlu+UM=;
        b=Hq9vOpI2uhFomEHwkanEzo6np95Pt0C4MdgV8IF3ZsoKhB2OPSMwfIA2dm5awvbabD
         JaGDfOTojfKnS88V9sUUB/2nzWUoTcdEvY65GfGI19MWfRzga2OsD4rHG2vngzeGcDJW
         fyO+3NIFrj7qnw19X+cmSiEI/7FtBPeh7q8V1tvDBENB8veFaiC1vJgEgG1JRZs1J3FE
         x+bxjk+62j9mYU3J4R8mPqfZ7G6bRfU1B8GHfc7a2Mc1zPI4vLq2HKMbvX+q0ozH/zBu
         hzxMEn1cAfbE62fSkBdnobH8sD60P6YnhtyXKtxb+NiyywGNhOvuyRW+wL6MbblDHzcf
         z+ng==
X-Forwarded-Encrypted: i=1; AJvYcCV1VxeBt5H4YvyKU8j9VISrKRqMn9SZQoUK2bWn+A3a4EbtS48ZMu+X5jEIhcYbWjklScvWbSkTVdsCbI8S@vger.kernel.org
X-Gm-Message-State: AOJu0YxPPoQOCkx2RlCXUgQE9g4hHjkDjQDTWtYKgjhyXHy94lg7lB9m
	N/2iKZ/z1tez2QBTrnaQDDWxzacdlaiUy/on+sWcEt1yRSj4NO+eA8IZ4TxgKE2LinXpkLQGyja
	qXmvfDLwCnpbt0r0Z+fNc/GgJOqCsTNsuhMBgjdDIBw==
X-Gm-Gg: ASbGncvl47GDm30ghbnhxJV2vI4Ua8eF99x+fiTnOaA+tH07WIehPr0N8yMHF4BhFdo
	Y4vR4ugJdIi/8layvRCH9q/T83AC7c8NBr7Rjpy+FYWLSKS1PDFXP9St2vuqTXWoT66P7SuP5v9
	mtcHUrot5BxUr0MyBedeMwveNb3Wpx3chAeKYSA4E6BUdAp7AjqF8fd/fHmoNBSERQWY5JI41j4
	p+RFy+q5gjqNvsGDqw5s02I3g+vUUGFUXDM28iqWpq1b2PJ7LvTC9GbgBU=
X-Google-Smtp-Source: AGHT+IGU1JVoYyv7CzlTWKa1ok4sgDwrvXsmRYqaQymnTJaYvBz9aHj6lCwmrP45DypLkDeS6k2ETKDOOEEc/ip0FCM=
X-Received: by 2002:ac8:59ca:0:b0:4e7:2d8b:ce5f with SMTP id
 d75a77b69052e-4eda4ec5ea1mr146269961cf.36.1762868691867; Tue, 11 Nov 2025
 05:44:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-copy-finish-v1-0-913ecf8aa945@ddn.com>
 <20251021-io-uring-fixes-copy-finish-v1-1-913ecf8aa945@ddn.com> <CAJnrk1aOsh-mFuueX0y=wvzvzF=MghNaLr85y+odToPB2pustg@mail.gmail.com>
In-Reply-To: <CAJnrk1aOsh-mFuueX0y=wvzvzF=MghNaLr85y+odToPB2pustg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Nov 2025 14:44:40 +0100
X-Gm-Features: AWmQ_bnJaLVOFkPGKtY0u21R6DEAFTB_g34UsCx6_brZ8Fndr61_N1ZAbAs77Es
Message-ID: <CAJfpegsXbmzPkVzg4HabnCeTmRFzsTjD_ESeR-JRhV7MPeO4NA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: missing copy_finish in fuse-over-io-uring
 argument copies
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Luis Henriques <luis@igalia.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Cheng Ding <cding@ddn.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 22:30, Joanne Koong <joannelkoong@gmail.com> wrote:

> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -649,6 +649,7 @@ static int fuse_uring_args_to_ring(struct
> fuse_ring *ring, struct fuse_req *req,
>         /* copy the payload */
>         err = fuse_copy_args(&cs, num_args, args->in_pages,
>                              (struct fuse_arg *)in_args, 0);
> +       fuse_copy_finish(&cs);
>         if (err) {
>                 pr_info_ratelimited("%s fuse_copy_args failed\n", __func__);
>                 return err;
>

Applied this variant.

Thanks,
Miklos

