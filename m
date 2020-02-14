Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB4D15CED1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 01:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgBNAAD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 19:00:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbgBNAAD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 19:00:03 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A0C3217F4;
        Fri, 14 Feb 2020 00:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581638402;
        bh=UrQXyz0IZ/cGcPKAlIBURYOtW8z0qfZYmQlNNIYIwpc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=z4nVqULA1zvW6NLruLoW9TDfkuasPT2hrS6aLGCtOeXqKx0DukDj9BzmAfl2IAFJh
         fo7SKZVY+3L0hXglVoLuoihHFtxO75nN1SiNWXpdrQ7FM2N5Q4ZqnljY5RZCEGbFg4
         hKWaD3wDPeavW75hOLdZT8KH8TSY7LNxOaWd0M04=
Message-ID: <9988adaa3849d526bfefdebccccef20dc3e7d696.camel@kernel.org>
Subject: Re: [PATCH 6/7] ceph: Switch to page_mkwrite_check_truncate in
 ceph_page_mkwrite
From:   Jeff Layton <jlayton@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Chao Yu <chao@kernel.org>, Richard Weinberger <richard@nod.at>
Cc:     linux-fsdevel@vger.kernel.org
Date:   Thu, 13 Feb 2020 19:00:00 -0500
In-Reply-To: <20200213202423.23455-7-agruenba@redhat.com>
References: <20200213202423.23455-1-agruenba@redhat.com>
         <20200213202423.23455-7-agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-02-13 at 21:24 +0100, Andreas Gruenbacher wrote:
> Use the "page has been truncated" logic in page_mkwrite_check_truncate
> instead of reimplementing it here.  Other than with the existing code,
> fail with -EFAULT / VM_FAULT_NOPAGE when page_offset(page) == size here
> as well, as should be expected.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/addr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 7ab616601141..ef958aa4adb4 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1575,7 +1575,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
>  	do {
>  		lock_page(page);
>  
> -		if ((off > size) || (page->mapping != inode->i_mapping)) {
> +		if (page_mkwrite_check_truncate(page, inode) < 0) {
>  			unlock_page(page);
>  			ret = VM_FAULT_NOPAGE;
>  			break;

Thanks Andreas. Merged into the ceph-client/testing branch and should
make v5.7.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

