Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E7A33D436
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 13:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhCPMuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 08:50:23 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:57978 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbhCPMuG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:50:06 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lM92W-006Vrv-M5; Tue, 16 Mar 2021 12:43:12 +0000
Date:   Tue, 16 Mar 2021 12:43:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <YFCn4ERBMGoqxvUU@zeniv-ca.linux.org.uk>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YE+oZkSVNyaONMd9@zeniv-ca.linux.org.uk>
 <202103151336.78360DB34D@keescook>
 <YFBdQmT64c+2uBRI@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFBdQmT64c+2uBRI@kroah.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 08:24:50AM +0100, Greg Kroah-Hartman wrote:

> > Completely agreed. seq_get_buf() should be totally ripped out.
> > Unfortunately, this is going to be a long road because of sysfs's ATTR
> > stuff, there are something like 5000 callers, and the entire API was
> > designed to avoid refactoring all those callers from
> > sysfs_kf_seq_show().
> 
> What is wrong with the sysfs ATTR stuff?  That should make it so that we
> do not have to change any caller for any specific change like this, why
> can't sysfs or kernfs handle it automatically?

Hard to tell, since that would require _finding_ the sodding ->show()
instances first.  Good luck with that, seeing that most of those appear
to come from templates-done-with-cpp...

AFAICS, Kees wants to protect against ->show() instances stomping beyond
the page size.  What I don't get is what do you get from using seq_file
if you insist on doing raw access to the buffer rather than using
seq_printf() and friends.  What's the point?
