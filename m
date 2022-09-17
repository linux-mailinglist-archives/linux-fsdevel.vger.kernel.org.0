Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36B05BB917
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Sep 2022 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIQPbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Sep 2022 11:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIQPbr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Sep 2022 11:31:47 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771EEB7D9;
        Sat, 17 Sep 2022 08:31:45 -0700 (PDT)
Received: from letrec.thunk.org (c-73-142-117-47.hsd1.ma.comcast.net [73.142.117.47])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28HFVZET013813
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Sep 2022 11:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1663428698; bh=P8X7BrdrxW4HqvXTvhAMJnCX+huMjVN2Vx33TFJijmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dx2CCf8SULDqFSMxx4Io4Pb2S1UjZqIRtq5xrTqs1ZLZx6xVGAz7lH1SYeUifAxWF
         gMHTdZzc0rK+2+nihZ9NI0p+hv9NvWHEk3lB5rkISBtmJ8pOozsyI96G2SyoprXXsx
         TagAFilQi7hJvNGQlCD2r8T1Xvsc7NW8dxjmnRcyLVKSe1haDmMkZthdOlL0MDkvNE
         7tT4IetagYU98i/2gYgVBHtNK1gra9YfTJI+wKzzN3xQPZ8ADyzsRhBO08D3ZJRu6d
         2PV5bIq3RS85iF08b6xbNhcGL67slp4S3IdSKrS8nUYjau3vRg1TgunZpt0eclJs2a
         03LDc+lWe8wbA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 5F8468C2C23; Sat, 17 Sep 2022 11:31:35 -0400 (EDT)
Date:   Sat, 17 Sep 2022 11:31:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [RFC] proc: report open files as size in stat() for /proc/pid/fd
Message-ID: <YyXoVxS5+FUA+vat@mit.edu>
References: <20220916230853.49056-1-ivan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916230853.49056-1-ivan@cloudflare.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 16, 2022 at 04:08:52PM -0700, Ivan Babrou wrote:
> We considered putting the number of open files in /proc/pid/stat.
> Unfortunately, counting the number of fds involves iterating the fdtable,
> which means that it might slow down /proc/pid/stat for processes
> with many open files. Instead we opted to put this info in /proc/pid/fd
> as a size member of the stat syscall result. Previously the reported
> number was zero, so there's very little risk of breaking anything,
> while still providing a somewhat logical way to count the open files.

Instead of using the st_size of /proc/<pid>/fd, why not return that
value in st_nlink?  /proc/<pid>/fd is a directory, so having st_nlinks
return number of fd's plus 2 (for . and ..) would be much more natural.

Cheers,

					- Ted
