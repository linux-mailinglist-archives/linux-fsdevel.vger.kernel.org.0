Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66A770273A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 10:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjEOIcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 04:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238321AbjEOIb1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 04:31:27 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94FF1701;
        Mon, 15 May 2023 01:31:26 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53063897412so5114399a12.0;
        Mon, 15 May 2023 01:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684139486; x=1686731486;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4VK51eI/t5c+51kYm+a78Tlw9GVzo2BN1qlFXbL5gxM=;
        b=dgHWCWXr/45mZVHx37pUXQ5ax3pSD27O0hK2QZ8u39ByY789Uu4NssssUd3z7ZkcpW
         2DgH38l/buoAWtH+zleNzK0iFwr7mJ501xhMwJofR4wF8kuukvdd1BAV1PYvUuNGghlB
         +nqbd09i3wigZOmXWDk4g549jn+ordOKe2z1+c8EExES4hhZfAxeCR4dN9wHKLQ2tmGM
         yoMMxeSPelwbPLMq6272ah2LagnkXZj+qhHGjmwyhTeLvuBIdtalX3Nh6tqLZNcfrtu+
         wWfSfJ8p3DbBvU+hiobmLkDtvf/p8ZdHGlzp9lcQs12dMXsPdfgbVKZ5ROS7OGBQ4IiS
         rGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684139486; x=1686731486;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4VK51eI/t5c+51kYm+a78Tlw9GVzo2BN1qlFXbL5gxM=;
        b=ITKGL0VQtfkhjssOXdKkC+6+BiKVvAbW5orTc6o9P4HkfYA7csVOuERnuhg8IZXDtP
         SxGF9ahgAXa4kPu4rFqM8eIBBvkX5YUrUt3CrMTMOU/SHYfyvygELkcd9ffDv7y5q2w7
         GMWXporDGO67Fj547UaA/b5OBOMNb9+7sLP/ju2rCAVbZjeTGMVCxB1O7AJSUChu0r+6
         L6w+nrB+nlN192JTKNNscbllrCg6ayJe9DNxojoVfVvyDbH0y3PH1MrlbnK1lWhm3188
         all2USfuHH91+uckSfK0v/p8tL1hBqMAffGz9e2FHRx3b2VIZE0MjvoPB5iEsQ2MYyTy
         u3vA==
X-Gm-Message-State: AC+VfDziwR7IEw1Fk/tcDsI+WvPfPebqcymUg0OlNZdZrZ5xwvcDcUZH
        hjGCo7zO5LY+6vLxxX6HP8U=
X-Google-Smtp-Source: ACHHUZ4r1zJo/M7Od73wSoUy4/JqVLUQxUGSohUkpS2AlgCsT9+nw31zZK4hcG6ZOq+vibt5IBA1rw==
X-Received: by 2002:a05:6a20:a129:b0:101:38f0:1a90 with SMTP id q41-20020a056a20a12900b0010138f01a90mr25981877pzk.1.1684139485970;
        Mon, 15 May 2023 01:31:25 -0700 (PDT)
Received: from rh-tp ([129.41.58.18])
        by smtp.gmail.com with ESMTPSA id h11-20020aa786cb000000b00646ec752fedsm10995364pfo.199.2023.05.15.01.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 01:31:25 -0700 (PDT)
Date:   Mon, 15 May 2023 14:01:08 +0530
Message-Id: <87v8guhu7n.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>, mcgrof@kernel.org
Subject: Re: [RFCv5 5/5] iomap: Add per-block dirty state tracking to improve performance
In-Reply-To: <20230515081613.rlnehghsypix5ddm@localhost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pankaj Raghav <p.raghav@samsung.com> writes:

>> @@ -1666,7 +1766,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>>  		struct writeback_control *wbc, struct inode *inode,
>>  		struct folio *folio, u64 end_pos)
>>  {
>> -	struct iomap_page *iop = iop_alloc(inode, folio, 0);
>> +	struct iomap_page *iop = iop_alloc(inode, folio, 0, true);
>>  	struct iomap_ioend *ioend, *next;
>>  	unsigned len = i_blocksize(inode);
>>  	unsigned nblocks = i_blocks_per_folio(inode, folio);
>> @@ -1682,7 +1782,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>>  	 * invalid, grab a new one.
>>  	 */
>>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
>> -		if (iop && !iop_test_block_uptodate(folio, i))
>> +		if (iop && !iop_test_block_dirty(folio, i))
>
> Shouldn't this be if(iop && iop_test_block_dirty(folio, i))?
>
> Before we were skipping if the blocks were not uptodate but now we are
> skipping if the blocks are not dirty (which means they are uptodate)?
>
> I am new to iomap but let me know if I am missing something here.
>

We set the per-block dirty status in ->write_begin. The check above happens in the
writeback path when we are about to write the dirty data to the disk.
What the check is doing is that, it checks if the block state is not dirty
then skip it which means the block was not written to in the ->write_begin().
Also the block with dirty status always means that the block is uptodate
anyways.

Hope it helps!

-ritesh
