Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D72363CD5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 22:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfGIUm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 16:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbfGIUm2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:42:28 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE7932073D;
        Tue,  9 Jul 2019 20:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562704947;
        bh=WuMoU6c/Nu0kKp80/Mw0OKcXEh7XR0qwBohejD1dIqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zeH5QyOsqThxkjJIZX95VM+NEDkLi3h3gW0ti8uqkiMXGMGer5nV3h1TJ/FFIECb2
         kMqY3IKr4hjxBxv9k3s2bHI44yVU4f1y1x2/WUR4VRGCHQdFBYuIEO46ZnbQ753TtK
         qB77okb7UD4mPGVERbK9snJgmKsv4zV3Hn5+uRg4=
Date:   Tue, 9 Jul 2019 13:42:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KEYS: Provide KEYCTL_GRANT_PERMISSION
Message-ID: <20190709204225.GM641@sol.localdomain>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <155862710003.24863.11807972177275927370.stgit@warthog.procyon.org.uk>
 <155862712317.24863.13455329541359881229.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155862712317.24863.13455329541359881229.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 04:58:43PM +0100, David Howells wrote:
> Provide a keyctl() operation to grant/remove permissions.  The grant
> operation, wrapped by libkeyutils, looks like:
> 
> 	int ret = keyctl_grant_permission(key_serial_t key,
> 					  enum key_ace_subject_type type,
> 					  unsigned int subject,
> 					  unsigned int perm);
> 
> Where key is the key to be modified, type and subject represent the subject
> to which permission is to be granted (or removed) and perm is the set of
> permissions to be granted.  0 is returned on success.  SET_SECURITY
> permission is required for this.
> 
> The subject type currently must be KEY_ACE_SUBJ_STANDARD for the moment
> (other subject types will come along later).
> 
> For subject type KEY_ACE_SUBJ_STANDARD, the following subject values are
> available:
> 
> 	KEY_ACE_POSSESSOR	The possessor of the key
> 	KEY_ACE_OWNER		The owner of the key
> 	KEY_ACE_GROUP		The key's group
> 	KEY_ACE_EVERYONE	Everyone
> 
> perm lists the permissions to be granted:
> 
> 	KEY_ACE_VIEW		Can view the key metadata
> 	KEY_ACE_READ		Can read the key content
> 	KEY_ACE_WRITE		Can update/modify the key content
> 	KEY_ACE_SEARCH		Can find the key by searching/requesting
> 	KEY_ACE_LINK		Can make a link to the key
> 	KEY_ACE_SET_SECURITY	Can set security
> 	KEY_ACE_INVAL		Can invalidate
> 	KEY_ACE_REVOKE		Can revoke
> 	KEY_ACE_JOIN		Can join this keyring
> 	KEY_ACE_CLEAR		Can clear this keyring
> 
> If an ACE already exists for the subject, then the permissions mask will be
> overwritten; if perm is 0, it will be deleted.
> 
> Currently, the internal ACL is limited to a maximum of 16 entries.
> 
> For example:
> 
> 	int ret = keyctl_grant_permission(key,
> 					  KEY_ACE_SUBJ_STANDARD,
> 					  KEY_ACE_OWNER,
> 					  KEY_ACE_VIEW | KEY_ACE_READ);
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Where is the documentation and tests for this?  I want to add syzkaller
definitions for this, but there is no documentation (a commit message doesn't
count).  I checked the 'next' branch of keyutils as well.

How is anyone supposed to use this if there is no documentation?

- Eric
