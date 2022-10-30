Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B00612769
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Oct 2022 06:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJ3FB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Oct 2022 01:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ3FB5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Oct 2022 01:01:57 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EE34B98F;
        Sat, 29 Oct 2022 22:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=snN+ahZB8RTEdCISFwrEpqTG30450n3SmkEIHv4+Nvs=; b=oCT8jdy8kiXLczS1q4R20j6sye
        YgYw+8RrUJwph4pbyQAHRQ6lq62IoLqCBgP3FP1dYCOzVqIqq6AzHtOB2kRekwDxBhP7/pxrsplpx
        YhNvq7jL6qEvTSmj+4kozHhBNkppCU6Tt1GyRKJjIKVbtxdWGpe6kmpoGyNW0wUWhUv8tHxBoB8pK
        25zKtS+BCMxf3UKIngz2X5i+tAKrJul5rF5Gu0L5YhJgeRl0f96MhS28cwY54iOiQO4EcS4H5bM9L
        aGsO3WSGCjcqxGcefu78Fc8H/pSCaooMAGV8QnuVp+RwffUf3POVhUKrdAHkLiIOEfX8OBMxEuqRa
        BcVL5QGw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1op0S3-00FSPo-14;
        Sun, 30 Oct 2022 05:01:39 +0000
Date:   Sun, 30 Oct 2022 05:01:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] use less confusing names for iov_iter direction
 initializers
Message-ID: <Y14FM9svxLoaOOuS@ZenIV>
References: <Y1btOP0tyPtcYajo@ZenIV>
 <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
 <20221028023352.3532080-12-viro@zeniv.linux.org.uk>
 <CAHk-=wibPKfv7mpReMj5PjKBQi4OsAQ8uwW_7=6VCVnaM-p_Dw@mail.gmail.com>
 <Y1wOR7YmqK8iBYa8@ZenIV>
 <CAHk-=wi_iDAugqFZxTiscsRCNbtARMFiugWtBKO=NqgM-vCVAQ@mail.gmail.com>
 <Y1wt7uzL7vkBQ6Vm@ZenIV>
 <CAHk-=wj4ndvhOFFsnNXRmwetwL9ZxE2QzcrLFTeJ7Yfh+pJ7Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj4ndvhOFFsnNXRmwetwL9ZxE2QzcrLFTeJ7Yfh+pJ7Mw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 01:34:05PM -0700, Linus Torvalds wrote:
> On Fri, Oct 28, 2022 at 12:30 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Went through the callers, replaced each with the right ITER_... (there's
> > not that many of them and they are fairly easy to review), then went
> > through mismatches and split their fixups into the beginning of the
> > series (READ -> ITER_SOURCE becoming READ -> WRITE -> ITER_SOURCE, that
> > is).
> 
> Oh, ok. So if you've actually reviewed each and every one of them,
> then I'm ok with the "abort".
> 
> I still want it to be a WARN_ON_ONCE(), because of any future addition
> that gets things wrong.

Sure, np; branch updated and pushed out - the only difference is that
11/12 adds WARN_ON_ONCE instead of WARN_ON, so no point reposting, IMO...
