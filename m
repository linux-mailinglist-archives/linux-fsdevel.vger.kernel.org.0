Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FF35076F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 20:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344083AbiDSSEq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 14:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238961AbiDSSEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:04:44 -0400
Received: from nibbler.cm4all.net (nibbler.cm4all.net [IPv6:2001:8d8:970:e500:82:165:145:151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FD23A192
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 11:02:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id 3ED21C00A1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 20:01:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id hPWNnCV-JEvv for <linux-fsdevel@vger.kernel.org>;
        Tue, 19 Apr 2022 20:01:52 +0200 (CEST)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id 218B6C00D5
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 20:01:52 +0200 (CEST)
Received: (qmail 2504 invoked from network); 19 Apr 2022 23:51:54 +0200
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 19 Apr 2022 23:51:54 +0200
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id E6D21460F1C; Tue, 19 Apr 2022 20:01:51 +0200 (CEST)
Date:   Tue, 19 Apr 2022 20:01:51 +0200
From:   Max Kellermann <mk@cm4all.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Max Kellermann <mk@cm4all.com>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fscache corruption in Linux 5.17?
Message-ID: <Yl75D02pXj71kQBx@rabbit.intern.cm-ag>
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
> Could the file have been modified by a third party?

According to our support tickets, the customers used WordPress's
built-in updater, which resulted in corrupt PHP sources.

We have configured stickiness in the load balancer; HTTP requests to
one website always go through the same web server.  Which implies that
the same web server that saw the corrupt files was the very same one
that wrote the new file contents.  This part surprises me, because
writing a page to the NFS server should update (or flush/invalidate)
the old cache page.  It would be easy for a *different* NFS client to
miss out on updated file contents, but this is not what happened.

On 2022/04/19 18:47, David Howells <dhowells@redhat.com> wrote:
> Do the NFS servers change the files that are being served - or is it
> just WordPress pushing the changes to the NFS servers for the web
> servers to then export?

I'm not sure if I understand this question correctly.  The NFS server
(a NetApp, btw.) sees the new file contents correctly; all other web
servers also see non-corrupt new files.  Only the one web server which
performed the update saw broken files.

Max
