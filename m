Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB894D3912
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 19:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiCISnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 13:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiCISns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D0AD18F221
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 10:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646851368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EiYo1sQ+iyTxNxBo5i2JTVVNprtfKtFAyovPZOOp01o=;
        b=UoV+3bSlF7xE8Ht5vzNJjv5h6MLGQJbbMTz/HbGEajh5Q5cWqPEC+ZWv40fi7xbxzr/uAQ
        7J+Qkj9FWxP+sOQRQVlqSolySz6KTvC7UeIIJHV/y/ijjbd/Ei8uLuncKh7FseSratBxe+
        MteJY0AO8d+xy5iFzFZzASf3CinNXKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-R6LYSyqyP3ineM-H9bcLww-1; Wed, 09 Mar 2022 13:42:47 -0500
X-MC-Unique: R6LYSyqyP3ineM-H9bcLww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E72C02F27;
        Wed,  9 Mar 2022 18:42:45 +0000 (UTC)
Received: from max.com (unknown [10.40.192.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 524F28EEB7;
        Wed,  9 Mar 2022 18:42:40 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
Date:   Wed,  9 Mar 2022 19:42:38 +0100
Message-Id: <20220309184238.1583093-1-agruenba@redhat.com>
In-Reply-To: <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com>
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com> <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com> <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com> <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com> <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com> <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com> <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com> <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 9, 2022 at 1:22 AM Linus Torvalds <torvalds@linux-foundation.or=
g> wrote:=0D
> On Tue, Mar 8, 2022 at 3:25 PM Andreas Gruenbacher <agruenba@redhat.com> =
wrote:=0D
> >=0D
> > Seems to be working on s390x for this test case at least; the kind of=0D
> > trace I'm getting is:=0D
>=0D
> Good.=0D
>=0D
> > This shows bursts of successful fault-ins in gfs2_file_read_iter=0D
> > (read_fault). The pauses in between might be caused by the storage;=0D
> > I'm not sure.=0D
>=0D
> Don't know about the pauses, but the burst size might be impacted by that=
=0D
>=0D
> + =C2=A0 =C2=A0 =C2=A0 const size_t max_size =3D 4 * PAGE_SIZE;=0D
>=0D
> thing that limits how many calls to fixup_user_fault() we do per=0D
> fault_in_safe_writeable().=0D
>=0D
> So it might be worth checking if that value seems to make any difference.=
=0D
>=0D
> > I'd still let the caller of fault_in_safe_writeable() decide how much=0D
> > memory to fault in; the tight cap in fault_in_safe_writeable() doesn't=
=0D
> > seem useful.=0D
>=0D
> Well, there are real latency concerns there - fixup_user_fault() is=0D
> not necessarily all that low-cost.=0D
=0D
I just don't know if making the GUP based approach work instead of=0D
switching to fixup_user_fault(), or introducing something else, would=0D
make enough of a performance difference to be worth it.=0D
=0D
> And it's actually going to be worse when we have the sub-page coloring=0D
> issues happening, and will need to probe at a 128-byte granularity=0D
> (not on s390, but on arm64).=0D
>=0D
> At that point, we almost certainly will need to have a "probe user=0D
> space non-destructibly for writability" instruction (possibly=0D
> extending on our current arch_futex_atomic_op_inuser()=0D
> infrastructure).=0D
=0D
Let me add Catalin Marinas to the CC.=0D
=0D
From what I took from the previous discussion, probing at a sub-page=0D
granularity won't be necessary for bytewise copying: when the address=0D
we're trying to access is poisoned, fault_in_*() will fail; when we get=0D
a short result, that will take us to the poisoned address in the next=0D
iteration.=0D
=0D
The problematic case was copying objects that cross fault domains, when=0D
we're getting an all-or-nothing result back from the copying and the=0D
address we're trying to fault_in_*() isn't the address of the actual=0D
fault.  The fix for those cases is to pass back the address of the=0D
actual fault in one way or another.=0D
=0D
> So honestly, if you do IO on areas that will get page faults on them,=0D
> to some degree it's a "you are doing something stupid, you get what=0D
> you deserve". This code should _work_, it should not have to worry=0D
> about users having bad patterns (where "read data into huge cold=0D
> mappings under enough memory pressure that it causes access bit faults=0D
> in the middle of the read" very much counts as such a bad pattern).=0D
=0D
With a large enough buffer, a simple malloc() will return unmapped=0D
pages, and reading into such a buffer will result in fault-in.  So page=0D
faults during read() are actually pretty normal, and it's not the user's=0D
fault.=0D
=0D
In my test case, the buffer was pre-initialized with memset() to avoid=0D
those kinds of page faults, which meant that the page faults in=0D
gfs2_file_read_iter() only started to happen when we were out of memory.=0D
But that's not the common case.=0D
=0D
> > Also, you want to put in an extra L here:=0D
> > > Signed-off-by: linus Torvalds <torvalds@linux-foundation.org>=0D
>=0D
> Heh. Fixed locally.=0D
=0D
Attached is a revised patch; only lightly tested so far.  Changes:=0D
=0D
* Fix the function description.=0D
=0D
* No need for untagged_addr() as that is handled in fixup_user_fault().=0D
=0D
* Get rid of max_size: it really makes no sense to second-guess what the=0D
  caller needs.  In cases where fault_in_safe_writeable() is used for=0D
  buffers larger than a handful of pages, it is entirely the caller's=0D
  responsibility to scale back the fault-in size in anticipation of or=0D
  in reaction to page-out.=0D
=0D
* Use the same control flow as in fault_in_readable(); there is no=0D
  need for anything more complicated anymore.=0D
=0D
* The same patch description still applies.=0D
=0D
Thanks,=0D
Andreas=0D
=0D
diff --git a/mm/gup.c b/mm/gup.c=0D
index f1bf3a1f6d109..5e777049bdf41 100644=0D
--- a/mm/gup.c=0D
+++ b/mm/gup.c=0D
@@ -1841,9 +1841,9 @@ EXPORT_SYMBOL(fault_in_writeable);=0D
  * @uaddr: start of address range=0D
  * @size: length of address range=0D
  *=0D
- * Faults in an address range using get_user_pages, i.e., without triggeri=
ng=0D
- * hardware page faults.  This is primarily useful when we already know th=
at=0D
- * some or all of the pages in the address range aren't in memory.=0D
+ * Faults in an address range for writing.  This is primarily useful when =
we=0D
+ * already know that some or all of the pages in the address range aren't =
in=0D
+ * memory.=0D
  *=0D
  * Other than fault_in_writeable(), this function is non-destructive.=0D
  *=0D
@@ -1856,46 +1856,33 @@ EXPORT_SYMBOL(fault_in_writeable);=0D
  */=0D
 size_t fault_in_safe_writeable(const char __user *uaddr, size_t size)=0D
 {=0D
-	unsigned long start =3D (unsigned long)untagged_addr(uaddr);=0D
-	unsigned long end, nstart, nend;=0D
+	const unsigned int fault_flags =3D FAULT_FLAG_WRITE | FAULT_FLAG_KILLABLE=
;=0D
+	unsigned long start =3D (unsigned long)uaddr, end;=0D
 	struct mm_struct *mm =3D current->mm;=0D
-	struct vm_area_struct *vma =3D NULL;=0D
-	int locked =3D 0;=0D
 =0D
-	nstart =3D start & PAGE_MASK;=0D
+	if (unlikely(size =3D=3D 0))=0D
+		return 0;=0D
 	end =3D PAGE_ALIGN(start + size);=0D
-	if (end < nstart)=0D
+	if (end < start)=0D
 		end =3D 0;=0D
-	for (; nstart !=3D end; nstart =3D nend) {=0D
-		unsigned long nr_pages;=0D
-		long ret;=0D
 =0D
-		if (!locked) {=0D
-			locked =3D 1;=0D
-			mmap_read_lock(mm);=0D
-			vma =3D find_vma(mm, nstart);=0D
-		} else if (nstart >=3D vma->vm_end)=0D
-			vma =3D vma->vm_next;=0D
-		if (!vma || vma->vm_start >=3D end)=0D
-			break;=0D
-		nend =3D end ? min(end, vma->vm_end) : vma->vm_end;=0D
-		if (vma->vm_flags & (VM_IO | VM_PFNMAP))=0D
-			continue;=0D
-		if (nstart < vma->vm_start)=0D
-			nstart =3D vma->vm_start;=0D
-		nr_pages =3D (nend - nstart) / PAGE_SIZE;=0D
-		ret =3D __get_user_pages_locked(mm, nstart, nr_pages,=0D
-					      NULL, NULL, &locked,=0D
-					      FOLL_TOUCH | FOLL_WRITE);=0D
-		if (ret <=3D 0)=0D
-			break;=0D
-		nend =3D nstart + ret * PAGE_SIZE;=0D
+	mmap_read_lock(mm);=0D
+	if (!PAGE_ALIGNED(start)) {=0D
+		if (fixup_user_fault(mm, start, fault_flags, NULL))=0D
+			return size;=0D
+		start =3D PAGE_ALIGN(start);=0D
 	}=0D
-	if (locked)=0D
-		mmap_read_unlock(mm);=0D
-	if (nstart =3D=3D end)=0D
-		return 0;=0D
-	return size - min_t(size_t, nstart - start, size);=0D
+	while (start !=3D end) {=0D
+		if (fixup_user_fault(mm, start, fault_flags, NULL))=0D
+			goto out;=0D
+		start +=3D PAGE_SIZE;=0D
+	}=0D
+	mmap_read_unlock(mm);=0D
+=0D
+out:=0D
+	if (size > (unsigned long)uaddr - start)=0D
+		return size - ((unsigned long)uaddr - start);=0D
+	return 0;=0D
 }=0D
 EXPORT_SYMBOL(fault_in_safe_writeable);=0D
 =0D

