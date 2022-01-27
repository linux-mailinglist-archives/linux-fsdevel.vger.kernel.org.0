Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A92649E3BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 14:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiA0Nks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 08:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiA0Nkr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:40:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF5AC061714;
        Thu, 27 Jan 2022 05:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A7isk/AEvohb1CbSlaMW9h+R22AoDLQSD18pleOQ9gk=; b=aX4qtRm/T0//lNN04V2OMgxdqo
        8ektTwVtWz21G87TzkQSTFKx7wdt7Rj95eTekvC+mB8/sn5aTfH5MaOnP8YNQM0BQ1P6/XzqjGAjF
        eDbKH1UmDhawMM+aRAVjauoh6MsVpDi1E5izKgBAMHQXp2zZ+qDbUgJVUSGB4FBq/3h6hk5w8Hann
        EsEXmTeG1QdTc7waSxqJiyS0nvRNvEiQL8V/eA7h6p+vIh/xnYCJ2cRdsVXoKebZAaxhNZ/jvWSZC
        LeD6kb+fdx0svTTpjCnGLMTkHF2wrk5Cp780oE0+jk/mTff7jQTyHA46aGJkequpYnWBsxb5Z1sIV
        QAqy1kLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD512-005HO2-OX; Thu, 27 Jan 2022 13:40:44 +0000
Date:   Thu, 27 Jan 2022 13:40:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Maxim Blinov <maxim.blinov@embecosm.com>,
        linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Help! How to delete an 8094-byte PATH?
Message-ID: <YfKg3DQS0h2lPo3z@casper.infradead.org>
References: <d4a67b38-3026-59be-06a8-3a9a5f908eb4@embecosm.com>
 <20220127122039.45kxmnm3s7kflo6h@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127122039.45kxmnm3s7kflo6h@riteshh-domain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 05:50:39PM +0530, Ritesh Harjani wrote:
> On 22/01/27 07:06AM, Maxim Blinov wrote:
> > $ for i in $(seq 999999); do echo "im $i levels deep"; cd confdir3; done;
> >
> > It then ran for a while, and eventually I got to the bottom:
> >
> > ```
> > ...
> > im 892 levels deep
> > im 893 levels deep
> > im 894 levels deep
> > im 895 levels deep
> > im 896 levels deep
> > bash: cd: confdir3: File name too long
> > $ ls
> > <nothing here>
> > ```
> >
> > So then, I `cd ../`, and `rmdir confdir3`, but even here, I get
> >
> > rmdir: failed to remove 'confdir3/': File name too long
> >
> > I would be very grateful if someone could please help suggest how I
> > might get this infernal tower of directories off of my precious ext4
> > partition.
> >
> > I was thinking maybe there's some kind of magic "forget this directory
> > inode ever existed" command, but I am out of my depth with filesystems.

here's an idea:

while true; do
	mv confdir3/confdir3 tmpd; rmdir confdir3; mv tmpd confdir3;
done
