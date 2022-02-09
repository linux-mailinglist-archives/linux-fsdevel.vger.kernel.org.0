Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC294B009F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 23:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbiBIWtX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 17:49:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbiBIWtW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:49:22 -0500
X-Greylist: delayed 1999 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 14:49:24 PST
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E607FE01925B;
        Wed,  9 Feb 2022 14:49:24 -0800 (PST)
Received: from dread.disaster.area (pa49-180-69-7.pa.nsw.optusnet.com.au [49.180.69.7])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 08C7510C707D;
        Thu, 10 Feb 2022 08:55:11 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nHuvd-00A6js-EK; Thu, 10 Feb 2022 08:55:09 +1100
Date:   Thu, 10 Feb 2022 08:55:09 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/6] NFSD: Fix NFSv4 SETATTR's handling of large file
 sizes
Message-ID: <20220209215509.GV59715@dread.disaster.area>
References: <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
 <164329971128.5879.15718457509790221509.stgit@bazille.1015granger.net>
 <20220128003641.GK59715@dread.disaster.area>
 <77B0ABAA-3427-4E4E-AE5A-B6D34FB6E837@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77B0ABAA-3427-4E4E-AE5A-B6D34FB6E837@oracle.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62043840
        a=NB+Ng1P8A7U24Uo7qoRq4Q==:117 a=NB+Ng1P8A7U24Uo7qoRq4Q==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8
        a=_-h6WkgsADSuhMYx-ykA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 28, 2022 at 01:48:48AM +0000, Chuck Lever III wrote:
> 
> 
> > On Jan 27, 2022, at 7:36 PM, Dave Chinner <david@fromorbit.com> wrote:
> > 
> > On Thu, Jan 27, 2022 at 11:08:31AM -0500, Chuck Lever wrote:
> >> IOW it assumes the caller has already sanity-checked the value.
> > 
> > Every filesystem assumes that the iattr that is passed to ->setattr
> > by notify_change() has been sanity checked and the parameters are
> > within the valid VFS supported ranges, not just XFS. Perhaps this
> > check should be in notify_change, not in the callers?
> 
> My (limited) understanding of the VFS code is that functions at
> the notify_change() level expect that its callers will have
> already sanitized the input -- those callers are largely the
> system call routines. That's why I chose to address this in NFSD.
> 
> Maybe inode_newsize_ok() needs to check for negative size values?

Yeah, that would seem reasonable - the size passed to it is a
loff_t, and it's not checked for overflows/negative values. So if it
checked for offset < 0 if would catch this....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
