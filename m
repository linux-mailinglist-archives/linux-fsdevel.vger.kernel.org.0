Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE76D4E81
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2019 11:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfJLJQX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Oct 2019 05:16:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:43241 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbfJLJQX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Oct 2019 05:16:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2019 02:16:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,287,1566889200"; 
   d="scan'208";a="188549955"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 12 Oct 2019 02:16:20 -0700
Date:   Sat, 12 Oct 2019 17:16:04 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs/userfaultfd.c: remove a redundant check on end
Message-ID: <20191012091604.GB6047@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190912213110.3691-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912213110.3691-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping for comment :-)

On Fri, Sep 13, 2019 at 05:31:08AM +0800, Wei Yang wrote:
>For the ending vma, there is a check to make sure the end is huge page
>aligned.
>
>The *if* check makes sure vm_start < end <= vm_end. While the first half
>is not necessary, because the *for* clause makes sure vm_start < end.
>
>This patch just removes it.
>
>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>---
> fs/userfaultfd.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>index 653d8f7c453c..9ce09ac619a2 100644
>--- a/fs/userfaultfd.c
>+++ b/fs/userfaultfd.c
>@@ -1402,8 +1402,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> 		 * If this vma contains ending address, and huge pages
> 		 * check alignment.
> 		 */
>-		if (is_vm_hugetlb_page(cur) && end <= cur->vm_end &&
>-		    end > cur->vm_start) {
>+		if (is_vm_hugetlb_page(cur) && end <= cur->vm_end) {
> 			unsigned long vma_hpagesize = vma_kernel_pagesize(cur);
> 
> 			ret = -EINVAL;
>-- 
>2.17.1

-- 
Wei Yang
Help you, Help me
