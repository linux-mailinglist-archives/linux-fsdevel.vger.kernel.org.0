Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561477061B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 09:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjEQHuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 03:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjEQHuP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 03:50:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA32F49CE;
        Wed, 17 May 2023 00:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 412ED64309;
        Wed, 17 May 2023 07:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACE2C433EF;
        Wed, 17 May 2023 07:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684309807;
        bh=gHbk0ucx0GMs+M8HKWhpclU1mbuhtBZOKMDwwu4F8tI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dG++y/69d3XpBt+dgNygyDUAzm2BStjA9csCTpYrdI8FzqSy5UoRnm3WatqTpHRZB
         23gnM1EEYhcU/7BzyHWfnYOPcJPVr7ndzMskofpC/eMzUhnaeaCLhb14+0tK4gkIAR
         /SEzDUvOO+ACaVk8tHw8pRKjmdk7Oy72PaZw41ctkV2BWYX4k1TEIQIrvE6SpUbXCS
         82TBxbB3fAAwdo0WYFEg+vvsjsk1LczV/3aegA9cvGFqyrefL/R4uL/ennX7r/L74T
         odsA8OyeZWJIFGHZkCEXHI4r4jWonuHXgQMObRcIgkb25KOgehYCkDi8d+oY9BNgdM
         wqXrO8oH8RC0g==
Date:   Wed, 17 May 2023 09:50:02 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A pass-through support for NFSv4 style ACL
Message-ID: <20230517-outen-galopp-cf33633006b5@brauner>
References: <20230516124655.82283-1-jlayton@kernel.org>
 <20230516-notorisch-geblickt-6b591fbd77c1@brauner>
 <TYXPR01MB18549D3A5B0BE777D7F6B284D9799@TYXPR01MB1854.jpnprd01.prod.outlook.com>
 <cc4317d9cb8f10aa0b3750bdb6db8b4e77ff26f8.camel@kernel.org>
 <20230517-herstellen-zitat-21eeccd36558@brauner>
 <ZGSGCTWOWkwIbvQE@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZGSGCTWOWkwIbvQE@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 12:45:13AM -0700, Christoph Hellwig wrote:
> On Wed, May 17, 2023 at 09:42:59AM +0200, Christian Brauner wrote:
> > I have no idea about the original flame war that ended RichACLs in
> > additition to having no clear clue what RichACLs are supposed to
> > achieve. My current knowledge extends to "Christoph didn't like them".
> 
> Christoph certainly doesn't like Rich ACLs, as do many other people.
> 
> But the deal block was that the patchset:
> 
>  - totally duplicated the VFS level ACL handling instead of having
>    a common object for Posix and the new ACLs

Which seems like a pretty obvious choice... That was the first thing I
thought of doing (see earlier mail).

>  - did add even more mess to the already horrible xattr interface
>    instead of adding syscalls.

Plus that was before I moved POSIX ACLs out of the xattr handlers so
they would've had to get that work done first for this to not end up a
horrible horrible mess...
