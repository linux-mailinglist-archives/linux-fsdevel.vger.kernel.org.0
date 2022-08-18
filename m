Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A96597E43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 07:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbiHRFwS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 01:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240655AbiHRFwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:52:16 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450048E463;
        Wed, 17 Aug 2022 22:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wHd9CWU9QIiZV8Sx+rqONgV8dh72yazoE4zaORY3LdU=; b=B1T/Q2Z+54m1kgVGIb5BGgFn+B
        IMKPOgMcqPgJ0RGJxT8Iyo3+IoNxGxTBKgn8SIh8Jgq8rO93kYz89b36YfjI0Qwffmmr7cSAuhVDQ
        1mP+boHgMr99PYvGv8cpHT+6w09JSP83XsEIMqcvdVvR7U3IF7cN1HExxIXyXqpgSl567pkM+OtSE
        w3fF8a66+wEmO8G0CMqQCzk6VzPXB72HtZjdswobV1A23eo7zwJzhJ6lhG2Chi2MPSRX4lTkPe2vj
        +T4Z6pzJnnssdUTpNQK76HeXo3O982udeo88SBTbDjfKD2bqZ85e7RPU1zspXku9OEtOxxbEHifTd
        6jqjbcDg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oOYRv-005csa-Tm;
        Thu, 18 Aug 2022 05:52:12 +0000
Date:   Thu, 18 Aug 2022 06:52:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] problems with alloc_file_pseudo() use in __nfs42_ssc_open()
Message-ID: <Yv3Ti/niVd5ZVPP+@ZenIV>
References: <Yv1jwsHVWI+lguAT@ZenIV>
 <CAN-5tyFvV7QOxyAQXu3UM5swQVB2roDpQ5CBRVc64Epp1gj9hg@mail.gmail.com>
 <Yv2BVKuzZdMDY2Td@ZenIV>
 <CAN-5tyF0ZMX8a6M6Qbbco3EmOzwVnnGZmqak8=t4Cvtzc45g7Q@mail.gmail.com>
 <CAOQ4uxgA8jD6KnbuHDevNLsjD-LbEs_y1W6uYMEY6EG_es0o+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgA8jD6KnbuHDevNLsjD-LbEs_y1W6uYMEY6EG_es0o+Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 08:19:54AM +0300, Amir Goldstein wrote:

> NFS spec does not guarantee the safety of the server.
> It's like saying that the Law makes Crime impossible.
> The law needs to be enforced, so if server gets a request
> to COPY from/to an fhandle that resolves as a non-regular file
> (from a rogue or buggy NFS client) the server should return an
> error and not continue to alloc_file_pseudo().

FWIW, my preference would be to have alloc_file_pseudo() reject
directory inodes if it ever gets such.

I'm still not sure that my (and yours, apparently) interpretation
of what Olga said is correct, though.
