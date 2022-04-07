Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6964F8BA3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 02:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiDGW3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 18:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiDGW3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 18:29:03 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3002614
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Apr 2022 15:27:00 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so7921822fac.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Apr 2022 15:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=OanOE6kLfCVolw3seEml8zkKEzMzrt00m4JCv7C/z4g=;
        b=hECnWD9CMlJMnL4LsnAestuOfSifCMULwkUTKJgRG4MJb/0TJtTlQ3lctHLoeQhzGi
         1NQosJXdRGNX/IDrmj05Bdfc0nHJrrZdFtQAL/unjFWktRHWHxL+qxQT9BQ61FoA69J4
         hJibBMNjV5UT0BS/2LSG8Hx5pqbevCl92RtbA6SGz/NHR9ZRSMYcD/z6WQy1QqkcKnnW
         vYwpEWC+g43CCMRgN3ooJUJypo5MZ1aQR+ERJ0rofMQiyxtNqh8mi0sGi8OK2Pw34WSk
         /Qnatf/38QK2EXQ2SDTEs6SImQIUNq/vLKBPkYaQYOp5KAyfIwbwyOPKagEYoyRtGaOr
         KgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=OanOE6kLfCVolw3seEml8zkKEzMzrt00m4JCv7C/z4g=;
        b=pqUUgyuBto1Yzz19u8TVgarNj5Xyp6l3XTZlsZ5I4ZZCRD4khuWZfJohIadTVvC3Mi
         7HKQ3VXL+NczNydo7twEq9blNDt+RdxHFaSd5Bvbn9+IfW3yfQHdddYxEp2VJvggIuF/
         +8nJM0KbzTMUokJwLIeuu+W1CNcXFkkwDsxHalw983dlyKMO62OXhqNmXYGBLhcgdX49
         4+De2ay8VCbcfrkwim/fT6WfdaJK02q17AlzXBzYtjivDE6A8ibZOEz3RWDS5ySc8x+T
         996v/ywoJXaw3pJrQv/xcRgerh2IH1mLJRZmlpIyMDw7mPi8//ncNoJh1Ve5IK7tLoRM
         s4AA==
X-Gm-Message-State: AOAM532TygWcQC3womkp0s5IDomAUePnDxUE0+II/oPQ7ThACey05fn7
        YSUhe6ApVUvnV5h27FT99NEgKA==
X-Google-Smtp-Source: ABdhPJxEt9CVgNYGbly3m8umObWCgx4U3LePMXCKHWoBvBmbMfLM3t+sgMB7jRk28HslodoVzrfP3g==
X-Received: by 2002:a05:6870:8896:b0:da:f5e5:5b62 with SMTP id m22-20020a056870889600b000daf5e55b62mr7334494oam.229.1649370419355;
        Thu, 07 Apr 2022 15:26:59 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m65-20020acabc44000000b002ed13d0fe6fsm7907732oif.23.2022.04.07.15.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 15:26:58 -0700 (PDT)
Date:   Thu, 7 Apr 2022 15:26:56 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Chuck Lever III <chuck.lever@oracle.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Hemment <markhemm@googlemail.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Regression in xfstests on tmpfs-backed NFS exports
In-Reply-To: <2B7AF707-67B1-4ED8-A29F-957C26B7F87A@oracle.com>
Message-ID: <c5ea49a-1a76-8cf9-5c76-4bb31aa3d458@google.com>
References: <673D708E-2DFA-4812-BB63-6A437E0C72EE@oracle.com> <11f319-c9a-4648-bfbb-dc5a83c774@google.com> <2B7AF707-67B1-4ED8-A29F-957C26B7F87A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 7 Apr 2022, Chuck Lever III wrote:
> > On Apr 6, 2022, at 8:18 PM, Hugh Dickins <hughd@google.com> wrote:
> > 
> > But I can sit here and try to guess.  I notice fs/nfsd checks
> > file->f_op->splice_read, and employs fallback if not available:
> > if you have time, please try rerunning those xfstests on an -rc1
> > kernel, but with mm/shmem.c's .splice_read line commented out.
> > My guess is that will then pass the tests, and we shall know more.
> 
> This seemed like the most probative next step, so I commented
> out the .splice_read call-out in mm/shmem.c and ran the tests
> again. Yes, that change enables the fsx-related tests to pass
> as expected.

Great, thank you for trying that.

> 
> > What could be going wrong there?  I've thought of two possibilities.
> > A minor, hopefully easily fixed, issue would be if fs/nfsd has
> > trouble with seeing the same page twice in a row: since tmpfs is
> > now using the ZERO_PAGE(0) for all pages of a hole, and I think I
> > caught sight of code which looks to see if the latest page is the
> > same as the one before.  It's easy to imagine that might go wrong.
> 
> Are you referring to this function in fs/nfsd/vfs.c ?

I think that was it, didn't pay much attention.

> 
>  847 static int
>  848 nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
>  849                   struct splice_desc *sd)
>  850 {
>  851         struct svc_rqst *rqstp = sd->u.data;
>  852         struct page **pp = rqstp->rq_next_page;
>  853         struct page *page = buf->page;
>  854 
>  855         if (rqstp->rq_res.page_len == 0) {
>  856                 svc_rqst_replace_page(rqstp, page);
>  857                 rqstp->rq_res.page_base = buf->offset;
>  858         } else if (page != pp[-1]) {
>  859                 svc_rqst_replace_page(rqstp, page);
>  860         }
>  861         rqstp->rq_res.page_len += sd->len;
>  862 
>  863         return sd->len;
>  864 }
> 
> rq_next_page should point to the first unused element of
> rqstp->rq_pages, so IIUC that check is looking for the
> final page that is part of the READ payload.
> 
> But that does suggest that if page -> ZERO_PAGE and so does
> pp[-1], then svc_rqst_replace_page() would not be invoked.

I still haven't studied the logic there: Mark's input made it clear
that it's just too risky for tmpfs to pass back ZERO_PAGE repeatedly,
there could be expectations of uniqueness in other places too.

> 
> > A more difficult issue would be, if fsx is racing writes and reads,
> > in a way that it can guarantee the correct result, but that correct
> > result is no longer delivered: because the writes go into freshly
> > allocated tmpfs cache pages, while reads are still delivering
> > stale ZERO_PAGEs from the pipe.  I'm hazy on the guarantees there.
> > 
> > But unless someone has time to help out, we're heading for a revert.

We might be able to avoid that revert, and go the whole way to using
iov_iter_zero() instead.  But the significant slowness of clear_user()
relative to copy to user, on x86 at least, does ask for a hybrid.

Suggested patch below, on top of 5.18-rc1, passes my own testing:
but will it pass yours?  It seems to me safe, and as fast as before,
but we don't know yet if this iov_iter_zero() works right for you.
Chuck, please give it a go and let us know.

(Don't forget to restore mm/shmem.c's .splice_read first!  And if
this works, I can revert mm/filemap.c's SetPageUptodate(ZERO_PAGE(0))
in the same patch, fixing the other regression, without recourse to
#ifdefs or arch mods.)

Thanks!
Hugh

--- 5.18-rc1/mm/shmem.c
+++ linux/mm/shmem.c
@@ -2513,7 +2513,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		pgoff_t end_index;
 		unsigned long nr, ret;
 		loff_t i_size = i_size_read(inode);
-		bool got_page;
 
 		end_index = i_size >> PAGE_SHIFT;
 		if (index > end_index)
@@ -2570,24 +2569,34 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			 */
 			if (!offset)
 				mark_page_accessed(page);
-			got_page = true;
+			/*
+			 * Ok, we have the page, and it's up-to-date, so
+			 * now we can copy it to user space...
+			 */
+			ret = copy_page_to_iter(page, offset, nr, to);
+			put_page(page);
+
+		} else if (iter_is_iovec(to)) {
+			/*
+			 * Copy to user tends to be so well optimized, but
+			 * clear_user() not so much, that it is noticeably
+			 * faster to copy the zero page instead of clearing.
+			 */
+			ret = copy_page_to_iter(ZERO_PAGE(0), offset, nr, to);
 		} else {
-			page = ZERO_PAGE(0);
-			got_page = false;
+			/*
+			 * But submitting the same page twice in a row to
+			 * splice() - or others? - can result in confusion:
+			 * so don't attempt that optimization on pipes etc.
+			 */
+			ret = iov_iter_zero(nr, to);
 		}
 
-		/*
-		 * Ok, we have the page, and it's up-to-date, so
-		 * now we can copy it to user space...
-		 */
-		ret = copy_page_to_iter(page, offset, nr, to);
 		retval += ret;
 		offset += ret;
 		index += offset >> PAGE_SHIFT;
 		offset &= ~PAGE_MASK;
 
-		if (got_page)
-			put_page(page);
 		if (!iov_iter_count(to))
 			break;
 		if (ret < nr) {
