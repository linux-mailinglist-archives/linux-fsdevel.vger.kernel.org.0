Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E365072A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 18:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354430AbiDSQJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 12:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354437AbiDSQJS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:09:18 -0400
Received: from nibbler.cm4all.net (nibbler.cm4all.net [IPv6:2001:8d8:970:e500:82:165:145:151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143803B29D
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 09:06:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id D07E4C00B9
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 18:06:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id lsEuYVWbRmu0 for <linux-fsdevel@vger.kernel.org>;
        Tue, 19 Apr 2022 18:06:23 +0200 (CEST)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id 03E2DC00E1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 18:06:20 +0200 (CEST)
Received: (qmail 26839 invoked from network); 19 Apr 2022 21:56:21 +0200
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 19 Apr 2022 21:56:21 +0200
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id C913A460F19; Tue, 19 Apr 2022 18:06:19 +0200 (CEST)
Date:   Tue, 19 Apr 2022 18:06:19 +0200
From:   Max Kellermann <mk@cm4all.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Max Kellermann <mk@cm4all.com>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fscache corruption in Linux 5.17?
Message-ID: <Yl7d++G25sNXIR+p@rabbit.intern.cm-ag>
References: <YlWWbpW5Foynjllo@rabbit.intern.cm-ag>
 <507518.1650383808@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <507518.1650383808@warthog.procyon.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/04/19 17:56, David Howells <dhowells@redhat.com> wrote:
> This is weird.  It looks like content got slid down by 31 bytes and 31 zero
> bytes got added at the end.  I'm not sure how fscache would achieve that -
> nfs's implementation should only be dealing with pages.

Did you read this part of my email?:

On 2022/04/12 17:10, Max Kellermann <max@rabbit.intern.cm-ag> wrote:
> The corruption can be explained by WordPress commit
> https://github.com/WordPress/WordPress/commit/07855db0ee8d5cff2 which
> makes the file 31 bytes longer (185055 -> 185086).  The "broken" web
> server sees the new contents until offset 184320 (= 45 * 4096), but
> sees the old contents from there on; followed by 31 null bytes
> (because the kernel reads past the end of the cache?).

My theory was that fscache shows a mix of old and new pages after the
file was modified.  Does this make sense?

Is there anything I can do to give you data from this server's cache?
