Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D836B2F60
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 22:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjCIVN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 16:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjCIVN5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:13:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83575E776A;
        Thu,  9 Mar 2023 13:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GX/fcDjqXbiud8lYARujqcmOd9zxNY2CS9n0xDw/OGs=; b=O1xySUPqu8oelqWJnDI9b46D/h
        B0aUPXPLBAxzY19u8+ubwJQ9sAgSskDG072eZ7zz8msH2Oz+MICbvJeFfESJrk6VU9OXyiY2V6kiv
        /rlirrGGYmyzYfqZs2VTp1Y5sqDQF6LHGUSjQst9SfC0v3cm7MGZAgxNauc7TnYaGORyc3M80xjc7
        P1/ibfUV0oYi/fLF28X78kwsMLolt0ieTIZ1Y6PlWuobkXVcvjbRfpEmhmYcdbdBXsLBLLWWuHIrM
        SVAZrLMnDUTiXe2AfYC4gV3ds68s3jLToVM4FEL5C4nmWL/OZWvhQbQhYJocr0xUp/YaGLpZFwYuL
        TSBhtuyw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paNa7-00BxAY-8M; Thu, 09 Mar 2023 21:13:47 +0000
Date:   Thu, 9 Mar 2023 13:13:47 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dan Helmick <dan.helmick@samsung.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZApMC8NLDfI6/ImD@bombadil.infradead.org>
References: <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
 <ZAWi5KwrsYL+0Uru@casper.infradead.org>
 <20230306161214.GB959362@mit.edu>
 <ZAjLhkfRqwQ+vkHI@casper.infradead.org>
 <CGME20230308181355eucas1p1c94ffee59e210fb762540c888e8eae8a@eucas1p1.samsung.com>
 <1367983d4fa09dcb63e29db2e8be3030ae6f6e8c.camel@HansenPartnership.com>
 <20230309080434.tnr33rhzh3a5yc5q@ArmHalley.local>
 <260064c68b61f4a7bc49f09499e1c107e2a28f31.camel@HansenPartnership.com>
 <yq11qlygevs.fsf@ca-mkp.ca.oracle.com>
 <f929f8d8e61da345be525ab06d4bb34ed2ce878b.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f929f8d8e61da345be525ab06d4bb34ed2ce878b.camel@HansenPartnership.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 03:49:50PM -0500, James Bottomley wrote:
> On Thu, 2023-03-09 at 10:23 -0500, Martin K. Petersen wrote:
> > > This is not to say I think larger block sizes is in any way a bad
> > > idea ... I just think that given the history, it will be driven by
> > > application needs rather than what the manufacturers tell us.
> > 
> > I think it would be beneficial for Linux to support filesystem blocks
> > larger than the page size. Based on experience outlined above, I am
> > not convinced larger logical block sizes will get much traction. But
> > that doesn't prevent devices from advertising larger
> > physical/minimum/optimal I/O sizes and for us to handle those more
> > gracefully than we currently do.
> 
> Right, I was wondering if we could try to persuade the Manufacturers to
> advertise a more meaningful optimal I/O size ...

Advocacy for using meaningful values is a real thing, Dan Helmick talked
about this at the last SDC 2022 at least for NVMe:

https://www.youtube.com/watch?v=3_M92RlVgIQ&ab_channel=SNIAVideo

A big future question is of course how / when to use these for filesystems.
Should there be, for instance a 'mkfs --optimal-bs' or something which
may look whatever hints the media uses ? Or do we just leaves the magic
incantations to the admins?

  Luis
