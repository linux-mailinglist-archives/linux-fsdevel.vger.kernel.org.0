Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53894507BE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 23:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356297AbiDSVa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 17:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345951AbiDSVa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:30:26 -0400
Received: from nibbler.cm4all.net (nibbler.cm4all.net [IPv6:2001:8d8:970:e500:82:165:145:151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A203B037
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 14:27:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id 6ECC9C00B9
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 23:27:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id gEwzYROHtBjQ for <linux-fsdevel@vger.kernel.org>;
        Tue, 19 Apr 2022 23:27:33 +0200 (CEST)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id 4CF37C00D5
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 23:27:33 +0200 (CEST)
Received: (qmail 17150 invoked from network); 20 Apr 2022 03:17:38 +0200
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 20 Apr 2022 03:17:38 +0200
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id 1563E460F19; Tue, 19 Apr 2022 23:27:33 +0200 (CEST)
Date:   Tue, 19 Apr 2022 23:27:33 +0200
From:   Max Kellermann <mk@cm4all.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Max Kellermann <mk@cm4all.com>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fscache corruption in Linux 5.17?
Message-ID: <Yl8pRVSW9y1o6MBV@rabbit.intern.cm-ag>
References: <Yl7d++G25sNXIR+p@rabbit.intern.cm-ag>
 <YlWWbpW5Foynjllo@rabbit.intern.cm-ag>
 <507518.1650383808@warthog.procyon.org.uk>
 <509961.1650386569@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <509961.1650386569@warthog.procyon.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/04/19 18:42, David Howells <dhowells@redhat.com> wrote:
> Could the file have been modified by a third party?  If you're using NFS3
> there's a problem if two clients can modify a file at the same time.  The
> second write can mask the first write and the client has no way to detect it.
> The problem is inherent to the protocol design.  The NFS2 and NFS3 protocols
> don't support anything better than {ctime,mtime,filesize} - the change
> attribute only becomes available with NFS4.

I tried to write a script to stress-test writing and reading, but
found no clue so far.  I'll continue that tomorrow.

My latest theory is that this is a race condition; what if one process
writes to the file, which invalidates the cache; then, in the middle
of invalidating the local cache and sending the write to the NFS
server, another process (on the same server) reads the file; what
modification time and what data will it see?  What if the cache gets
filled with old data, while new data to-be-written is still in flight?

Max
