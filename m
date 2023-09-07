Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC6F79774D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 18:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241576AbjIGQYN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 12:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244264AbjIGQX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:23:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F777EF3;
        Thu,  7 Sep 2023 09:13:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04F5C433C9;
        Thu,  7 Sep 2023 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694101800;
        bh=ogud9LayuNxA5epVuVZz59vt/VQoyZTG7PTl81uTp8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUgap7cWFuKCa4PzjEmfD7qA5bEg4ToR1RgTOSE+0anALQLA8rb0aoaa3HkXVFJ5O
         LDB+OVa6mYfYspsYNajmp2hazKUJujr7/ujwdKBxCQO9xzQjcUhed3cKKf7or7kVJQ
         zEaJHLUzIkrN4dVjplI5gvrGQy1JSFgJ289/eNpe3MI2GuE1ujn2jmG5HE5qt8gYVM
         Lo423kUOLaO7NzTBlkgos06S3xuR9Rqn3KUzcBxuyDYaiA4kZFUISaBw5VbRdqqBmw
         jFSohpUZokXHmNQaJ+RZ126vvjlbM85JLeatZeu1dTGenf0kuzVxOXIAPHhw4MpVME
         uHd7r0J3NIWsw==
Date:   Thu, 7 Sep 2023 17:49:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 13/13] ntfs3: free the sbi in ->kill_sb
Message-ID: <20230907-liebgeworden-leidwesen-331fc399f71e@brauner>
References: <20230809220545.1308228-1-hch@lst.de>
 <20230809220545.1308228-14-hch@lst.de>
 <56f72849-178a-4cb7-b2e1-b7fc6695a6ef@roeck-us.net>
 <20230907-lektion-organismus-f223e15828d9@brauner>
 <dc4b7b2c-89c0-d16f-43e2-0aec5c9b8e1b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc4b7b2c-89c0-d16f-43e2-0aec5c9b8e1b@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 07, 2023 at 08:23:09AM -0700, Guenter Roeck wrote:
> On 9/7/23 06:54, Christian Brauner wrote:
> > On Thu, Sep 07, 2023 at 06:05:40AM -0700, Guenter Roeck wrote:
> > > On Wed, Aug 09, 2023 at 03:05:45PM -0700, Christoph Hellwig wrote:
> > > > As a rule of thumb everything allocated to the fs_context and moved into
> > > > the super_block should be freed by ->kill_sb so that the teardown
> > > > handling doesn't need to be duplicated between the fill_super error
> > > > path and put_super.  Implement an ntfs3-specific kill_sb method to do
> > > > that.
> > > > 
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > Reviewed-by: Christian Brauner <brauner@kernel.org>
> > > 
> > > This patch results in:
> > 
> > The appended patch should fix this. Are you able to test it?
> > I will as well.
> 
> Yes, this patch restores the previous behavior (no more backtrace or crash).

Great, I'll get this fixed in upstream.

> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> I say "restore previous behavior" because my simple "recursive copy; partially
> remove copied files" test still fails. That problem apparently existed since
> ntfs3 has been introduced (I see it as far back as v5.15).

I don't think anyone finds that surprising.
