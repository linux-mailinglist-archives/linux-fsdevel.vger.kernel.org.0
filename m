Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F42D56265E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 01:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiF3XCB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 19:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiF3XB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:01:59 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB4753D3D;
        Thu, 30 Jun 2022 16:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xsduXeYpmYNCgboOcGK4VNY+9k6YY2Ixlo9C8vms2e4=; b=ZBDESSTIfrnnm6hKzRVvdIl1ix
        dgLjjyV2Nev4pj2vRYyc37c1fFexZ8efPNcLd8D/PdBGnz2Huf9bqusubprgoi542GG2N9qNNcQXR
        Q9InCgdUpoFWAycJM2KnJglPOdozkhIp1OWQopjZhI3GXZ4p8wmyS8BkAczlaeQUJqI752n2AwXsq
        dy3lnx4msooiYUCGZo/xRLYj4VnHvAUyEhcmEmV3EXaSf+HGC+CgF5QDRaD7riKXh1BP06GeNa2VC
        kYMxRf3z7vA9VJ1ZW7Lt5YOT8nD2OwL7g3+0VQFTHgoiu7+1Hh+Sy5V/jgrFa7dbpOhtdeHEXAj5a
        HLLJLuGA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o739z-006ijm-JP;
        Thu, 30 Jun 2022 23:01:19 +0000
Date:   Fri, 1 Jul 2022 00:01:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: Re: [PATCH v2 2/9] mm/mshare: pre-populate msharefs with information
 file
Message-ID: <Yr4rP7rfxqOzxbCZ@ZenIV>
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <34e2eabbef5916c784dc16856ce25b3967f9b405.1656531090.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34e2eabbef5916c784dc16856ce25b3967f9b405.1656531090.git.khalid.aziz@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:53:53PM -0600, Khalid Aziz wrote:

> +static void
> +mshare_evict_inode(struct inode *inode)
> +{
> +	clear_inode(inode);
> +}

Again, what for?  And while we are at it, shouldn't you evict the
pages when inode gets freed and ->i_data along with it?
IOW, aren't you missing
                truncate_inode_pages_final(&inode->i_data);
That, or just leave ->evict_inode NULL...
