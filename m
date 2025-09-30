Return-Path: <linux-fsdevel+bounces-63122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2DABAE5F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 20:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECFC64E297A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 18:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4522773D4;
	Tue, 30 Sep 2025 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HsQi4k5Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E934BA50
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258556; cv=none; b=MNlgDcelky2NH7hjHOVLTU8ptuyCaCjmEhEd4Z2gr6aMYue5bYZCTpKuJWrwRAtia73yUzrC5kRAH6kSxqW147gm9S4FWawHxQgLfeBoehtb8xXqe7LkJIM5g+usvH0gO/p6OE8LiJ7SJ9eqGQex7ihWME0DsHjwQjbfKf2HSF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258556; c=relaxed/simple;
	bh=g4XTpAdzBEBKTpeuRPJ1fQ2ET0Hk7V6k94DiU7N+Pwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eb6JvacwRBYd0cia/F39lhUVb7rsb1FmmK4osqzw8sXgJNArzDcGTzkrlzMTpjRaC/z4O7tumj4rIwuyKhIZFUYgqz7bTZ5eTKP4GvPyPFocfuKh2BthALjOoqeDYOQOyR1nuLFpr/Krrw8ybea6hU9HjAN1sato9ZXbobKwKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HsQi4k5Q; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-854585036e8so640240585a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1759258552; x=1759863352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g4XTpAdzBEBKTpeuRPJ1fQ2ET0Hk7V6k94DiU7N+Pwg=;
        b=HsQi4k5QI+dsMSrnatjfS23eksYqhwF6gEX3ptmN7aDUsuwXan4pqrrPwFdyjSczAE
         Av3/xxr1WlzZcTbGXzEYU5I7Mrxr9jk8cjyBRwJzUpmvj8rCAtfCB8OoAncOVIAmgpCT
         cU8tcLh8qNWBvOC2h+rZT3xcXqqd4YBaPB+/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258552; x=1759863352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4XTpAdzBEBKTpeuRPJ1fQ2ET0Hk7V6k94DiU7N+Pwg=;
        b=YLAu42H2lheAmdLTLJPp6T8BePhPbQ07DtrNCh2E85RT6E4vOyrqEX1LyroSW40QN5
         0fvD74VbKjq5bxJjf9cYBSCjAzI89RgIQ+ueVZT5IZ0FMKqeW08fw3TfA6Dj4ZJhGjih
         USiicPTga4J5GdRY8DhClw6iWzTSqBscMamaXwrDzcHoJXjwcFjnYY44HmVofSVleK+n
         jjWs0uWCEgetjbpguFY7m72F7IDHqCt/rEG6joGp+ZAxS7d5dIcgShKb52Uvf3yQ4hWl
         3xHuTIKTsxj3jxbXplNt6/ljs+TWvd9hfPLNBUT+l2qdDI8Vp6/uiKFdyxfkON3rhemJ
         NaQA==
X-Forwarded-Encrypted: i=1; AJvYcCUomasxXkn+UqHRyv65hbDNbWwHJP3m6uZttmm5G49pwQUTTJ617wTHT6vu7ZgIhhPvF1ZeOpiRgMf1VStw@vger.kernel.org
X-Gm-Message-State: AOJu0YxH5IVCurHMEmSzytiJmcuV2W+Z51GJF7foeX94EGRlrutegT/0
	HLh7flnBr1ynVLS2oQ4QAhPwmc4XSyCaQ9jwyfEbP399b5Wel/nYOL3rZjXyXEKPB53LuQxfLwM
	YScwKXrjjK+2HlYjd4CW8TbqgzFwoDSUZCLC8+UF1aw==
X-Gm-Gg: ASbGncvm7k5kg8hHsHQEblDr9pbAFww7vyYPPR1gpRQVCHgK8Dax33sILljehXUur4A
	cnA59Dp20QHwi6AwVGsMSig9ZqNL+ryK7hhMzi5Rn06NJGTUDM9lTZ+cWnsAiaA+Ti+Ht7om1YM
	LotJN7az4+OQgqt22aMwSuhSEvWJ9FF9lQ09KNVxKmWEfPgrKvzHY0hphJ6Xgq3AH3g12xJ6olP
	8u+QtD3LxVFY0LBdKj1szGns/BBDz93zI9E3/TCDp/EPJb6lGl6VW47jtPxIEwDtdNZfFIFUA==
X-Google-Smtp-Source: AGHT+IG/ZPEKi2JV0RVi3jzJKUTH5YPQu8q3kYXKaLZtfsXYVvNsvLw53Yg9spS5dgANf/c68MWlKQD07UbtcgTVB+4=
X-Received: by 2002:a05:620a:444d:b0:85e:24c3:a60f with SMTP id
 af79cd13be357-87376d724camr128659385a.65.1759258552385; Tue, 30 Sep 2025
 11:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925224404.2058035-1-joannelkoong@gmail.com>
 <dc3fbd15-1234-485e-a11d-4e468db635cd@linux.alibaba.com> <9e9d5912-db2f-4945-918a-9c133b6aff81@linux.alibaba.com>
 <CAJnrk1b=0ug8RMZEggVQpcQzG=Q=msZimjeoEPwwp260dbZ1eg@mail.gmail.com>
 <a517168d-840f-483b-b9a1-4b9c417df217@linux.alibaba.com> <CAJfpeguSW1mSjdDZg2AnTGmRqe7F9+WhCHd3Byt2J7v4vscrsA@mail.gmail.com>
 <CAJnrk1Zty=+n4JEeOAWywhtBNQ5cNzHVFzPVY=KSHhX5Qs_1Yw@mail.gmail.com>
In-Reply-To: <CAJnrk1Zty=+n4JEeOAWywhtBNQ5cNzHVFzPVY=KSHhX5Qs_1Yw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 30 Sep 2025 20:55:41 +0200
X-Gm-Features: AS18NWD1B251ySV0EM_70-IOaQSJw8RDYl4Ze6XrCBrm3FrADWB8fP5ZukH_jKw
Message-ID: <CAJfpegta+q6vz0KWji62cvB2VPG6qscKERC7iH8ZR-_et3AAaQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix readahead reclaim deadlock
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	osandov@fb.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Sept 2025 at 20:47, Joanne Koong <joannelkoong@gmail.com> wrote:

> Or am I missing something here? I'm not super familiar with the mmap
> code but as far as I can tell from the logic in vm_mmap_pgoff() ->
> do_mmap() -> __mmap_region(), it doesn't grab a refcount on the inode
> or the file descriptor.

mmap keeps a ref on the file (vma->vm_file), so only munmap() will
trigger ->release().

Thanks,
Miklos

