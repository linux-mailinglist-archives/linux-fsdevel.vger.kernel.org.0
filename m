Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED791C4A86
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2019 11:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfJBJWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 05:22:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:57440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbfJBJWH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:22:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A5ECAE8A;
        Wed,  2 Oct 2019 09:22:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5D024DA88C; Wed,  2 Oct 2019 11:22:21 +0200 (CEST)
Date:   Wed, 2 Oct 2019 11:22:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Markus.Elfring@web.de,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Sterba <dsterba@suse.com>, emamd001@umn.edu,
        kjlu@umn.edu, smccaman@umn.edu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs: affs: fix a memory leak in affs_remount
Message-ID: <20191002092221.GJ2751@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Navid Emamdoost <navid.emamdoost@gmail.com>, Markus.Elfring@web.de,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Sterba <dsterba@suse.com>, emamd001@umn.edu, kjlu@umn.edu,
        smccaman@umn.edu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
References: <ec7d3fdb-445b-7f4e-d6e6-77c6ae9a5732@web.de>
 <20190930210114.6557-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930210114.6557-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 30, 2019 at 04:01:10PM -0500, Navid Emamdoost wrote:
> In affs_remount if data is provided it is duplicated into new_opts.
> The allocated memory for new_opts is only released if pare_options fail.
> The release for new_opts is added.

A variable that is allocated and freed without use should ring a bell to
look closer at the code. There's a bit of history behind new_options,
originally there was save/replace options on the VFS layer so the 'data'
passed must not change (thus strdup), this got cleaned up in later
patches. But not completely.

There's no reason to do the strdup in cases where the filesystem does
not need to reuse the 'data' again, because strsep would modify it
directly.

So new_opts should be removed. 
