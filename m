Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8A079962
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 22:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfG2UPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 16:15:15 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41355 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729147AbfG2UPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:15:10 -0400
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6TKElfw026772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jul 2019 16:14:48 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AC8394202F5; Mon, 29 Jul 2019 16:14:45 -0400 (EDT)
Date:   Mon, 29 Jul 2019 16:14:45 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v7 06/16] fscrypt: add FS_IOC_ADD_ENCRYPTION_KEY ioctl
Message-ID: <20190729201445.GA16445@mit.edu>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-7-ebiggers@kernel.org>
 <20190728185003.GF6088@mit.edu>
 <20190729194644.GE169027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729194644.GE169027@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 29, 2019 at 12:46:45PM -0700, Eric Biggers wrote:
> > For that matter, we could just add a new ioctl which returns the file
> > system's keyring id.  That way an application program won't have to
> > try to figure out what a file's underlying sb->s_id happens to be.
> > (Especially if things like overlayfs are involved.)
> 
> Keep in mind that the new ioctls (FS_IOC_ADD_ENCRYPTION_KEY,
> FS_IOC_REMOVE_ENCRYPTION_KEY, FS_IOC_GET_ENCRYPTION_KEY_STATUS) don't take the
> keyring ID as a parameter, since it's already known from the filesystem the
> ioctl is executed on.  So there actually isn't much that can be done with the
> keyring ID.  But sure, if it's needed later we can add an API to get it.

Yeah, I was thinking about for testing/debugging purposes so that we
could use keyctl to examine the per-file system keyring and see what
keys are attached to a file system.  This is only going to be usable
by root, so I guess we can just try to figure it out by going through
/proc/keys and searching by sb->s_id.  If there are ambiguities that
make this hard to do, we can add an interface to make this easier.

     	       	      	     - Ted
