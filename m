Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6025356B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 08:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfFEGOU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 02:14:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfFEGOU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:14:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB02020673;
        Wed,  5 Jun 2019 06:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559715260;
        bh=+A9AY46wDMVuQ3gxGKxmv3kf004kikgeSAYOrLu1ICs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sQ/geVitjSHZHAQGJNctFVzbDJC+QVMYiUlqmSjIx2U0k22+CZTYERL+Ojk3y8stQ
         H0juK58AFD1A8xmgK+YMExFmQpSjR2GuErGvFiGLvoDMFU9HnFwy+GeL1EQ4PsFGOa
         XHWfUKh/CWuOhBODxxuFi1vyFYmpn0xMTZ5KR7o4=
Date:   Wed, 5 Jun 2019 08:14:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Daniel Axtens <dja@axtens.net>, nayna@linux.ibm.com,
        cclaudio@linux.ibm.com, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, George Wilson <gcwilson@us.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Garrett <mjg59@google.com>,
        Elaine Palmer <erpalmer@us.ibm.com>
Subject: Re: [WIP RFC PATCH 0/6] Generic Firmware Variable Filesystem
Message-ID: <20190605061417.GA29846@kroah.com>
References: <20190520062553.14947-1-dja@axtens.net>
 <316a0865-7e14-b36a-7e49-5113f3dfc35f@linux.vnet.ibm.com>
 <87zhmzxkzz.fsf@dja-thinkpad.axtens.net>
 <20190603072916.GA7545@kroah.com>
 <90d3394f-c2e6-5d47-0ebd-0ddb28f3f883@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90d3394f-c2e6-5d47-0ebd-0ddb28f3f883@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 04, 2019 at 04:33:14PM -0400, Nayna wrote:
> 
> 
> On 06/03/2019 03:29 AM, Greg KH wrote:
> > On Mon, Jun 03, 2019 at 04:04:32PM +1000, Daniel Axtens wrote:
> > > Hi Nayna,
> > > 
> > > > > As PowerNV moves towards secure boot, we need a place to put secure
> > > > > variables. One option that has been canvassed is to make our secure
> > > > > variables look like EFI variables. This is an early sketch of another
> > > > > approach where we create a generic firmware variable file system,
> > > > > fwvarfs, and an OPAL Secure Variable backend for it.
> > > > Is there a need of new filesystem ? I am wondering why can't these be
> > > > exposed via sysfs / securityfs ?
> > > > Probably, something like... /sys/firmware/secureboot or
> > > > /sys/kernel/security/secureboot/  ?
> > > I suppose we could put secure variables in sysfs, but I'm not sure
> > > that's what sysfs was intended for. I understand sysfs as "a
> > > filesystem-based view of kernel objects" (from
> > > Documentation/filesystems/configfs/configfs.txt), and I don't think a
> > > secure variable is really a kernel object in the same way most other
> > > things in sysfs are... but I'm open to being convinced.
> > What makes them more "secure" than anything else that is in sysfs today?
> > I didn't see anything in this patchset that provided "additional
> > security", did I miss it?
> > 
> > > securityfs seems to be reserved for LSMs, I don't think we can put
> > > things there.
> > Yeah, I wouldn't mess with that.
> 
> Thanks Greg for clarifying!! I am curious, the TPM exposes the BIOS
> event log to userspace via securityfs. Is there a reason for not
> exposing these security variables to userspace via securityfs as well?

securityfs is for LSMs to use.  If the TPM drivers also use it, well,
that's between those authors and the securityfs developers.

BIOS/firmware variables are a much different thing than a TPM log.

thanks,

greg k-h
