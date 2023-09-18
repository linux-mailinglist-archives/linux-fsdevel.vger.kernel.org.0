Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8951E7A51E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjIRSSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRSSm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:18:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61E3FD;
        Mon, 18 Sep 2023 11:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GZ84gVRI2PX7ahj9yRYTfsVG+X1DsmYAjFhvQECzP0A=; b=KzAz5wBnPEz1nehYFezXzF/d1+
        +P0ffc/qIqaeWx2fcXjR+cpFD4Bb1JITYhUyextiLiqXelX1Hh4loVLZEHp4Kg9D9YKKnKylB0qV2
        flgNGh28V0hsH5A+UrRB82A14tLQo9JNMsu0MJG4OvdP8Z28VdGx3rtDgJrVSRNhe/8S1NuAaFhIU
        q4cWVMhgBFJ0/1wQ9GMRJ/x3RY1DJgkcCm5VZXeHArk8nb3an/6ifgN0uASUf4YTF3iuPSpS38sDh
        zMAp4oNMD3t0PNGUi4fKv4y4mL7bDxlMIxRp2gfloQpmGR7CZ1Ccsk8sZUbr56O8WZqcXQ95Yu/bH
        vh7pjFOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiIpL-00CUQS-7X; Mon, 18 Sep 2023 18:18:31 +0000
Date:   Mon, 18 Sep 2023 19:18:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     syzbot <syzbot+c225dea486da4d5592bd@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [fs?] [mm?] WARNING in page_copy_sane
Message-ID: <ZQiUd5FAtPXP3OC8@casper.infradead.org>
References: <0000000000003a7ffb06059ac0dd@google.com>
 <d576d53b-bce4-21d3-fddd-0e26e9b44f89@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d576d53b-bce4-21d3-fddd-0e26e9b44f89@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:10:21PM -0500, Sidhartha Kumar wrote:
> @@ -382,8 +382,8 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  			/*
>  			 * We have the page, copy it to user space buffer.
>  			 */
> -			copied = copy_page_to_iter(page, offset, want, to);
> -			put_page(page);
> +			copied = copy_page_to_iter(&folio->page, offset, want, to);

copy_folio_to_iter() please.  Yes, I know it's just a wrapper today.

> +			folio_put(folio);
>  		}
>  		offset += copied;
>  		retval += copied;
> -- 
> 2.41.0
> 

