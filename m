Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F34467830F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjAWR0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjAWR0k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:26:40 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 09:26:35 PST
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CD62ED47;
        Mon, 23 Jan 2023 09:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=jxizD/Q3eZgm8v2atJKpzOhe4pIRsKwj+ZQgS95fBiA=; b=M2NrmAr0OqXvl//udKahfWWwbd
        t+cYTklTVox4MzeOrzE38tFHWDBGtUwMPfBg5HTM7Zrl18oBa6sx8StzUNRKNlG9dYfrnqxO9wY13
        WpxnDLgUfu8vbfQZ3GlAoeYfnINvDQ3wHP619T9Xp4tJIZZpNTTL9VwnNyBCyCra6vOwhI23x7Sjm
        seu9hN8qGfxVzCbhIUoB35QY+2bgL33Au26PTt2VrNCMv/sljWn4lob9ivdXb2TbRaUf1ZrvWLXa8
        grqt2he0F19b14mv3KrVspUNGLZEMS+C9jlURJnQJVvfZkzViqxPdxdHwU0gfsXBhKLaia9QfZX6I
        isSJn4iPMqCx3r401PLYZkjwFZdmH/2eBSVBLURMJJb7jKZsXNRbxQ9r1eFc/eVi3PYT98HMRRWTF
        L88qa0j5mXyBMLlbGd+xrurYB14sQvyOHU0FjC54MzkHma7AFW6oJye1JzhQiNLn8B9zLBuW5/XE2
        y1z3UigeIlmR3KFHj6s8gKISV7hVJtRr0u8Jzbmus3E/dR4qrINCItP6FLl2GJhslceBtNeNj15P+
        vKxj0MImY/TOp2bp3R2h6IkBPgITpkxQGifTudpVECucv/GR9aXfU9HIXksczvq19YnlsxVNK6koq
        dQ4w5vHwe6nKNxKxKQUqGmwg5lZcmYVWJYNSH22gI=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net,
        Eric Van Hensbergen <evanhensbergen@icloud.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Van Hensbergen <evanhensbergen@icloud.com>
Subject: Re: [PATCH v2 00/10] Performance fixes for 9p filesystem
Date:   Mon, 23 Jan 2023 17:31:05 +0100
Message-ID: <4478705.9R3AOq7agI@silver>
In-Reply-To: <20221218232217.1713283-1-evanhensbergen@icloud.com>
References: <20221217183142.1425132-1-evanhensbergen@icloud.com>
 <20221218232217.1713283-1-evanhensbergen@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday, December 19, 2022 12:22:07 AM CET Eric Van Hensbergen wrote:
> This is the second version of a patch series which adds a number
> of features to improve read/write performance in the 9p filesystem.
> Mostly it focuses on fixing caching to help utilize the recently
> increased MSIZE limits and also fixes some problematic behavior
> within the writeback code.
> 
> Altogether, these show roughly 10x speed increases on simple
> file transfers.  Future patch sets will improve cache consistency
> and directory caching.
> 
> These patches are also available on github:
> https://github.com/v9fs/linux/tree/ericvh/9p-next
> 
> Tested against qemu, cpu, and diod with fsx, dbench, and some
> simple benchmarks.
> 
> Signed-off-by: Eric Van Hensbergen <evanhensbergen@icloud.com>

Hi Eric,

what's your plan on this series? I just had a look at your github repo and saw
there is a lot of stuff marked as WIP.

Best regards,
Christian Schoenebeck


