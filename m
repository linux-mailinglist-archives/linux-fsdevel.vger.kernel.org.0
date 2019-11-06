Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2555F0CFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 04:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfKFD0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 22:26:41 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57284 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730655AbfKFD0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:26:41 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA63QMGp027897
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Nov 2019 22:26:23 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4AC21420311; Tue,  5 Nov 2019 22:26:20 -0500 (EST)
Date:   Tue, 5 Nov 2019 22:26:20 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 2/3] ext4: add support for IV_INO_LBLK_64 encryption
 policies
Message-ID: <20191106032620.GF26959@mit.edu>
References: <20191024215438.138489-1-ebiggers@kernel.org>
 <20191024215438.138489-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024215438.138489-3-ebiggers@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 02:54:37PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> IV_INO_LBLK_64 encryption policies have special requirements from the
> filesystem beyond those of the existing encryption policies:
> 
> - Inode numbers must never change, even if the filesystem is resized.
> - Inode numbers must be <= 32 bits.
> - File logical block numbers must be <= 32 bits.
> 
> ext4 has 32-bit inode and file logical block numbers.  However,
> resize2fs can re-number inodes when shrinking an ext4 filesystem.
> 
> However, typically the people who would want to use this format don't
> care about filesystem shrinking.  They'd be fine with a solution that
> just prevents the filesystem from being shrunk.
> 
> Therefore, add a new feature flag EXT4_FEATURE_COMPAT_STABLE_INODES that
> will do exactly that.  Then wire up the fscrypt_operations to expose
> this flag to fs/crypto/, so that it allows IV_INO_LBLK_64 policies when
> this flag is set.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

LGTM

Acked-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
