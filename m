Return-Path: <linux-fsdevel+bounces-67776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2BCC49C98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 00:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5169F188C327
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15B62FD689;
	Mon, 10 Nov 2025 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mEGty8YH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C267B288C22
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 23:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817953; cv=none; b=XyZLiAZuMJQyrOKX4jOBKVdhc6GrXnQNyylzxTAo5cXpmiFuRDQIU952llJqPA42w6VeofarNuG46c1kgZDj8LV+NqDr+pTxeJvqTig9j276K+W9PeqMPa7b0gMMDUMVRDZ2/teHv/3ZvvAv9E7eltOgYZ//puSomV53NNxXHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817953; c=relaxed/simple;
	bh=Dn/NYX3Wj4798jgUyiyxe8j2iflj/zcXoK6zpJuJGpw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YsUUZagMTr68JZfd77p+6aV95zyFzQ6ARtHqDZGxgW8At6K6ukZGyo3miOBU49oYqKe2rP5ee7pgfN14+k+hTfEW7gJU4REA84ycxLmms7z+1i72vZmhQvz4LqryTIaVnTFaEA+P5WcVweE1uINrANTFhmY2ICacHBtjQnuOVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mEGty8YH; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-787e7aa1631so3592877b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 15:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762817951; x=1763422751; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=auOCGMGZsgkQSYvZ+oudFtHe19C6Wc96WcK7gMZx0zg=;
        b=mEGty8YHoT9lQfsMZxDzImwxoSukZsGElucuwailTczNWbXvFVZVaib8NlFztpaXjv
         DINb0HvO59EpPjVQfH0dH4S9w7v5cVqho+oGE80jK/g5WRlAsbjgkFwn5QPHyC8nmK07
         yb9DAiwpQJrZc/sRM2CnfxddXUN01w56nFY8HfWO2EUoGU9B2AAnDCx3C+julOLyBBDr
         h9cm2VEX4KSRyrToAhtT6SMUYjDHt+wAtEhNMLGz+qUy2MiCJ8q18pspYRWMbS2LzXe4
         h17Xk9fpaU8yFq9XP6jrXvmBGM87DwA5BW+gedZmfW58GymS/Yo9xOliYgTr4VWJQHJe
         9OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762817951; x=1763422751;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auOCGMGZsgkQSYvZ+oudFtHe19C6Wc96WcK7gMZx0zg=;
        b=EvMeBwWr92xTwZB7sawhd8R/cyHNlXqjSZt0nmHmi0EJ/g0PvgiX1anQC8t2WsPC66
         TDg1FIvOOHNKhsuMJjFeHy96RCHhJUn8TDRLhTjio4KDd64JK+3+oRHmwvZGn0Ya7TWh
         4Wu9AL700BmPFTxQuF7tV0Zqb/iVQWzxgKo6stya/eVWFfq8VTIxZx9RuKFqHcyaUTha
         +hAAnQiQC8LyA9eaJCTIi1Te1vOlF7MqpfmhEvtnddZKxYjmK3uCvgdGfZIrsbZDPRZ+
         rk2zxwsCufM4T3Ld0x1FWLpTsm05Ihs8NBHPfrBMSn+knHwZWKBNGZak7ofG2i8y+HeN
         cLSw==
X-Forwarded-Encrypted: i=1; AJvYcCVzyVXN6Y6g1ucDgbOnhycvBUfKrnL+pi+rveAdLCGsmtJN3n85OYi0IVMEGG5r4zV0t+tinOtEDRfZ0oQE@vger.kernel.org
X-Gm-Message-State: AOJu0YxkjquafuVCUo7ZW18ASrwL7Zn99pYqIcu0otjO5oa7A2cX/gGh
	4fVw5YzG/PqB+M8YDm+msAkgicMpsS7xK0IENzplW1R4PmeavL3EdtHG9H4mq+Voqg==
X-Gm-Gg: ASbGncuK6HwVMJyTHqtlO9/Rjcuph0wYk01LfokCCs7hJS2cs2YK/kVdCqNYF2zwP38
	rzRUXrVBuvoqy5GHA4rwsMEpQ0EZ3myg8bqvB4ZtsXn8/feuMRmfMiF/yPV/yR8h97vlN1kNDp/
	TbklJurt+p4Cms/JiOMBeI96gL/OG/r9RZ1Yr7bZ897BnKOZUMKWPWuhdCg0vV2Y+FqbfsjsoNw
	FKpvtpyvG/bE2hlCv5nUs9U26wzyivN5ObzMuKibmJ7NkwcdfV9Xv1I4Vm/jTH7fPQsPbPcEwnD
	iVOeA9eLDbDJwVUSNamSwj4tI2gyUuDQozDTQcSUqPLpS8a+lnjJDI0H/H1sxhG1Ls48p1qkTdF
	sB1hvBin3atdKhn9LwU+HoekmTq6Q+ECW571r1n6WqBp/ATcaP/M9vT4qaqnBCFybLYgopYTZa3
	JlVWt2xIG8uAOf/RdCJwA4JZWfDCsz+pQ2GQ1Z4VhQUNbh/45SZ5CUtjS5sS2xMMMtWztSy/t/f
	fWM5vfZ9w==
X-Google-Smtp-Source: AGHT+IGhKzpHrBaCl8nie6rdibzD1wCPS/Sl7zTN9XwZ4g855DlbGN22SspoKQKrIKKHgp9q/nU6ag==
X-Received: by 2002:a81:8a07:0:b0:787:d107:ca88 with SMTP id 00721157ae682-7880355f82bmr9116177b3.10.1762817950151;
        Mon, 10 Nov 2025 15:39:10 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d6a2947asm27792067b3.55.2025.11.10.15.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 15:39:09 -0800 (PST)
Date: Mon, 10 Nov 2025 15:38:55 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Janosch Frank <frankja@linux.ibm.com>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@redhat.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
    Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
    Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
    Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
    Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
    Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
    Michal Hocko <mhocko@suse.com>, Matthew Brost <matthew.brost@intel.com>, 
    Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
    Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
    Ying Huang <ying.huang@linux.alibaba.com>, 
    Alistair Popple <apopple@nvidia.com>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
    Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
    Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
    SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
    Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
    Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>, 
    Naoya Horiguchi <nao.horiguchi@gmail.com>, 
    Pedro Falcato <pfalcato@suse.de>, 
    Pasha Tatashin <pasha.tatashin@soleen.com>, 
    Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
    Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, 
    kvm@vger.kernel.org, linux-s390@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
In-Reply-To: <3c0e9dd0-70ac-4588-813b-ffb24d40f067@lucifer.local>
Message-ID: <c9e3ad0e-02ef-077c-c12c-f72057eb7817@google.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com> <CACePvbVq3kFtrue2smXRSZ86+EuNVf6q+awQnU-n7=Q4x7U9Lw@mail.gmail.com> <5b60f6e8-7eab-4518-808a-b34331662da5@lucifer.local> <CACePvbUvQu+So7OoUbJTMLODz8YDAOgWaM8A-RXFj2U_Qc-dng@mail.gmail.com>
 <3c0e9dd0-70ac-4588-813b-ffb24d40f067@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 10 Nov 2025, Lorenzo Stoakes wrote:
> On Mon, Nov 10, 2025 at 03:04:48AM -0800, Chris Li wrote:
> >
> > That is actually the reason to give the swap table change more
> > priority. Just saying.
> 
> I'm sorry but this is not a reasonable request. I am being as empathetic and
> kind as I can be here, but this series is proceeding without arbitrary delay.
> 
> I will do everything I can to accommodate any concerns or issues you may have
> here _within reason_ :)

But Lorenzo, have you even tested your series properly yet, with
swapping and folio migration and huge pages and tmpfs under load?
Please do.

I haven't had time to bisect yet, maybe there's nothing more needed
than a one-liner fix somewhere; but from my experience it is not yet
ready for inclusion in mm and next - it stops testing other folks' work.

I haven't tried today's v3, but from the cover letter of differences,
it didn't look like much of importance is fixed since v2: which
(after a profusion of "Bad swap offet entry 3ffffffffffff" messages,
not seen with v1, and probably not really serious) soon hits an Oops
or a BUG or something (as v1 did) - I don't have any logs or notes
to give yet, just forewarning before pursuing later in the day.

If you think v3 has fixed real crashes under load, please say so:
otherwise, I doubt it's worth Andrew hurrying to replace v2 by v3.

(Or have I got something bad in my build, and will have to apologize?
Or am I blaming your series - seems most likely - when it's actually
something else which came into mm in the last week?)

Hugh

