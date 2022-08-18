Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DB9597EAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 08:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbiHRGc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 02:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHRGc1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:32:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A15CA3D7D;
        Wed, 17 Aug 2022 23:32:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E076EB81FFF;
        Thu, 18 Aug 2022 06:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A5FC433C1;
        Thu, 18 Aug 2022 06:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660804344;
        bh=Kqr77NyLJGS64iGu/RtqfYqcdRHgst5RRJdReOBJ4MA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rE3Ul1r/xBzy8REQeOSMR5W9G3qtjDIFEqDZwzPjSHVs6/tM/sOEIKW1kULxas2S8
         UfeAwG7e0k+L51z4LgM//64ayk4rwS8oP1bO/8jKUtlUAHfZxuXVAmaYXgC9Q+1xh1
         uDRyYrP60BbBsqlTH9X1oxB4yGYRUh5a4g/3dg+4=
Date:   Thu, 18 Aug 2022 08:32:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v6 2/5] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Message-ID: <Yv3c9jYkyWfe2zMM@kroah.com>
References: <20220817214728.489904-1-axelrasmussen@google.com>
 <20220817214728.489904-3-axelrasmussen@google.com>
 <Yv3bnouKb7242Ama@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv3bnouKb7242Ama@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 08:26:38AM +0200, Greg KH wrote:
> On Wed, Aug 17, 2022 at 02:47:25PM -0700, Axel Rasmussen wrote:
> > +static int userfaultfd_dev_open(struct inode *inode, struct file *file)
> > +{
> > +	return 0;
> 
> If your open does nothing, no need to list it here at all, right?
> 
> > +}
> > +
> > +static long userfaultfd_dev_ioctl(struct file *file, unsigned int cmd, unsigned long flags)
> > +{
> > +	if (cmd != USERFAULTFD_IOC_NEW)
> > +		return -EINVAL;
> > +
> > +	return new_userfaultfd(flags);
> > +}
> > +
> > +static const struct file_operations userfaultfd_dev_fops = {
> > +	.open = userfaultfd_dev_open,
> > +	.unlocked_ioctl = userfaultfd_dev_ioctl,
> > +	.compat_ioctl = userfaultfd_dev_ioctl,
> 
> Why do you need to set compat_ioctl?  Shouldn't it just default to the
> existing one?
> 
> And why is this a device node at all?  Shouldn't the syscall handle all
> of this (to be honest, I didn't read anything but the misc code, sorry.)

Ah, read the documentation now.  Seems you want to make it easier for
people to get permissions on a system.  Doesn't seem wise, but hey, it's
not my feature...

thanks,

greg k-h
