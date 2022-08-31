Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59475A88E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 00:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiHaWR7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 18:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHaWR6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:17:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F191E9926;
        Wed, 31 Aug 2022 15:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=pYm+OJZ/TWf4BrwMl+a6D7AiKW4DyIXMD3Q3PmPJ9t0=; b=Pzy2DmyRzwYok40yKeubZLuOfD
        iofNAjQR0rCmGUAnHyRPg1DUeZqX4rtrKajdqp7KCChT9q1TZhE4IXOIWLCAAolof17cZO42giknP
        34awWlH9moDh09zBeOrYdHBQ3zVdWIywqsVKBNZmxn6ZLM9YX9K+hsinQEn5LVeaFSZDJBJViCzau
        95mEf6y7V7bOdOtq7115ef9JW+1iS6GjFNGcoGBiX2vTqEW868ZqIpCx0cKYVJXfAULIij5EG1wcu
        DEi7vJF52FMB2enDyiSWfqUsMO8w4ZXF7p/Y5f3Se1evmsSAMAqk5CdMIN1bP2AKQQYix9A1ycFoM
        hBS0K+pA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oTW1y-00Akq9-PO;
        Wed, 31 Aug 2022 22:17:54 +0000
Date:   Wed, 31 Aug 2022 23:17:54 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fs/xattr: add *at family syscalls
Message-ID: <Yw/eEufm/QpKg5Pq@ZenIV>
References: <20220830152858.14866-1-cgzones@googlemail.com>
 <20220830152858.14866-2-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830152858.14866-2-cgzones@googlemail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[linux-arch Cc'd for ABI-related stuff]

On Tue, Aug 30, 2022 at 05:28:39PM +0200, Christian Göttsche wrote:
> Add the four syscalls setxattrat(), getxattrat(), listxattrat() and
> removexattrat() to enable extended attribute operations via file
> descriptors.  This can be used from userspace to avoid race conditions,
> especially on security related extended attributes, like SELinux labels
> ("security.selinux") via setfiles(8).
> 
> Use the do_{name}at() pattern from fs/open.c.
> Use a single flag parameter for extended attribute flags (currently
> XATTR_CREATE and XATTR_REPLACE) and *at() flags to not exceed six
> syscall arguments in setxattrat().

	I've no problems with the patchset aside of the flags part;
however, note that XATTR_CREATE and XATTR_REPLACE are actually exposed
to the network - the values are passed to nfsd by clients.
See nfsd4_decode_setxattr() and
        BUILD_BUG_ON(XATTR_CREATE != SETXATTR4_CREATE);
	BUILD_BUG_ON(XATTR_REPLACE != SETXATTR4_REPLACE);
in encode_setxattr() on the client side.

	Makes me really nervous about constraints like that.  Sure,
AT_... flags you are using are in the second octet and these are in
the lowest one, but...
