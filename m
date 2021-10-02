Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8DA41F91E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Oct 2021 03:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhJBBX0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 21:23:26 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57991 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230255AbhJBBXZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 21:23:25 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1921LXju001968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Oct 2021 21:21:34 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BB75015C34AA; Fri,  1 Oct 2021 21:21:33 -0400 (EDT)
Date:   Fri, 1 Oct 2021 21:21:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] fs: ext4: Fix the inconsistent name exposed by
 /proc/self/cwd
Message-ID: <YVe0HS8HM48LDUDS@mit.edu>
References: <cover.1632909358.git.shreeya.patel@collabora.com>
 <8402d1c99877a4fcb152de71005fa9cfb25d86a8.1632909358.git.shreeya.patel@collabora.com>
 <YVdWW0uyRqYWSgVP@mit.edu>
 <8735pk5zml.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735pk5zml.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 01, 2021 at 03:11:30PM -0400, Gabriel Krisman Bertazi wrote:
> 
> The dcache name is exposed in more places, like /proc/mounts.  We have a
> bug reported against flatpak where its initialization code bind mounts a
> directory that was previously touched with a different case combination,
> and then checks /proc/mounts in a case-sensitive way to see if the mount
> succeeded.  This code now regresses on CI directories because the name
> it asked to bind mount is not found in /proc/mounts.

Ah, thanks for the context.  That makes sense.

> I think the more reasonable approach is to save the disk exact name on
> the dcache, because that is the only version that doesn't change based
> on who won the race for the first lookup.

What about the alternative of storing the casefolded name?  The
advantage of using the casefolded name is that we can always casefold
the name, where as in the case of a negative dentry, there is no disk
exact name to use (since by definition there is no on-disk name).

      	      	  	    	       - Ted
