Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A330364DDB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 16:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiLOPVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 10:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiLOPVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:21:10 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A4122524;
        Thu, 15 Dec 2022 07:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=veWqpQXIk6sP3oOKoPG/TZGs2w9yCqcBMZk/w842K00=; b=QbNQuPdyKRFdDd4vHkfoRgJo9/
        2FiN/5ro9QZsnj+FWx2oWEjf16PdPmyp1LW6MWVgAgLAw6gBUblFg4GhIKRxt1Weox1/gxj2p1gki
        wKqqQPElTKHIZ1aq4ZCnk+si4ytzhH4gwNNFBgK+0Q+4aMuU+kYKs4yKemH9M8O1Ya4itX9+2STsp
        S1zH6aUWo1+8Xzz2acQaLnEsbmEqsee/iALnBwhqMNrPl5CFKPgFhEs8hMXcm1QAIQP5RHDJE7Pp5
        udVGt+AKOy+X8UUJaT8qVx93oUI9npbGrwRmeLIH8rv+uH0zAValHAGU+vqV3aO8xFcIKTHsvWYk1
        5BoWsuCg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p5q1X-00C3Q0-1K;
        Thu, 15 Dec 2022 15:19:51 +0000
Date:   Thu, 15 Dec 2022 15:19:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Wei Chen <harperchen1110@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: possible deadlock in __ata_sff_interrupt
Message-ID: <Y5s7F/4WKe8BtftB@ZenIV>
References: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
 <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 15, 2022 at 06:48:20PM +0900, Damien Le Moal wrote:

> The problem is here: sg_rq_end_io() calling kill_fasync(). But at a quick
> glance, this is not the only driver calling kill_fasync() with a spinlock
> held with irq disabled... So there may be a fundamental problem with
> kill_fasync() function if drivers are allowed to do that, or the reverse,
> all drivers calling that function with a lock held with irq disabled need
> to be fixed.
> 
> Al, Chuck, Jeff,
> 
> Any thought ?

What is the problem with read_lock_irqsave() called with irqs disabled?
read_lock_irq() would have been a bug in such conditions, of course, but
that's not what we use...
