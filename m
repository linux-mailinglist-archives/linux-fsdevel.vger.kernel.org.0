Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3AF7B3CC2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 00:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjI2Wt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 18:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Wt0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:49:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807ECDD;
        Fri, 29 Sep 2023 15:49:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57E9C433C8;
        Fri, 29 Sep 2023 22:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696027764;
        bh=Ufhqxo3yas1XlwZ8/C+WysTlrYXwdeYXTChlz66gL/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RqmEBvELKiKJrPdmj27E6wWm3wbgoGhbztCnJy3K8fbCsufv51Lo9qUuXj8sTFb4C
         zU3wRai4oALXDco5xkF66XgYStzG6E7Va5LNHKv2nVFCtNMduKicVQ7BzAu6Gg3pLo
         DyVc3WaIDXXS3CqCCT0fschckPSyFzmlt/dbLDBIpO+CvPw8eAtrVBCEpTUG6UJ+bE
         sM6pS/HdnnAFfJXBhYTF3VU7HubdFFtuXEKr8TIhEZZpMR0qJOHhOjaM14WcTCkW8u
         3/kp7PQcfopDGxKohL2jgFUOHFzUYt/CpLGVJQYxOo+j5L/uayzxWPWpO76hsI2ut3
         Ym9Y7/TXMwICw==
Date:   Fri, 29 Sep 2023 22:49:22 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
Message-ID: <20230929224922.GB11839@google.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-4-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-4-john.g.garry@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 10:27:08AM +0000, John Garry wrote:
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 7cab2c65d3d7..c99d7cac2aa6 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -127,7 +127,10 @@ struct statx {
>  	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
>  	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
>  	/* 0xa0 */
> -	__u64	__spare3[12];	/* Spare space for future expansion */
> +	__u32	stx_atomic_write_unit_max;
> +	__u32	stx_atomic_write_unit_min;

Maybe min first and then max?  That seems a bit more natural, and a lot of the
code you've written handle them in that order.

> +#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */

How would this differ from stx_atomic_write_unit_min != 0?

- Eric
