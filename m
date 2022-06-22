Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B395548DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 14:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354372AbiFVKfJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 06:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbiFVKfI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:35:08 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11163B561;
        Wed, 22 Jun 2022 03:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eBAMnDo2A2dyiL8GImJYSvjocj5z0gmHhJC/cQDizRc=; b=uNxTxCK9boI3FpAQY3vXXazKK9
        z7Jk3/i6calEzMlh8bsDkdIe12D98ixDCjL04eHemGCLut+piHi5NAUm73LLHTynYB1kn3vWqE2la
        QZOsKygKbOofTXUETehcn6JlIqHzalQAaRAjydAJ0QMk6Ms8Nx5tCtOFS4zkqnYdc89zZVrSAs3+J
        hdOqCNnCRUm4MGHpyaiAfvcWiUpNLdZjTWT82jW5L3TOPpkRmQUgo/LvJ1q/Tnyo6/IGLuqKrj4ss
        KIuFIYocRURF3keX6Gc/vXtBSxva7vbhdrDo1LkGrPoQhHbzYqMfP+48auWU6YyvEbINm3uwHuMlb
        LYqyI+wA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3xhL-003BUA-Gw;
        Wed, 22 Jun 2022 10:34:59 +0000
Date:   Wed, 22 Jun 2022 11:34:59 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     sunliming <sunliming@kylinos.cn>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sunliming@kylino.cn, kelulanainsley@gmail.com
Subject: Re: [PATCH] walk_component(): get inode in lookup_slow branch
 statement block
Message-ID: <YrLwU27DNm0YWOvB@ZenIV>
References: <20220622085146.444516-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622085146.444516-1-sunliming@kylinos.cn>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 04:51:46PM +0800, sunliming wrote:
> The inode variable is used as a parameter by the step_into function,
> but is not assigned a value in the sub-lookup_slow branch path. So
> get the inode in the sub-lookup_slow branch path.

Take a good look at handle_mounts() and the things it does when
*not* in RCU mode (i.e. LOOKUP_RCU is not set).  Specifically,
                *inode = d_backing_inode(path->dentry);
		*seqp = 0; /* out of RCU mode, so the value doesn't matter */
this part.

IOW, the values passed to step_into() in inode/seq are overridden unless
we stay in RCU mode.  And if we'd been through lookup_slow(), we'd been
out of RCU mode since before we called step_into().
