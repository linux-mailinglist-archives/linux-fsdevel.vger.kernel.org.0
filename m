Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41D01040F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 05:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfEADA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 23:00:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57075 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725909AbfEADAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 23:00:55 -0400
Received: from callcc.thunk.org (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x412xVCE001527
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Apr 2019 22:59:32 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 95C10420023; Tue, 30 Apr 2019 22:59:30 -0400 (EDT)
Date:   Tue, 30 Apr 2019 22:59:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Olaf Weber <olaf@sgi.com>,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] unicode: refactor the rule for regenerating utf8data.h
Message-ID: <20190501025930.GB5377@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Olaf Weber <olaf@sgi.com>,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-fsdevel@vger.kernel.org
References: <1556507731-830-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556507731-830-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 29, 2019 at 12:15:31PM +0900, Masahiro Yamada wrote:
> scripts/mkutf8data is used only when regenerating utf8data.h,
> which never happens in the normal kernel build. However, it is
> irrespectively built if CONFIG_UNICODE is enabled.
> 
> Moreover, there is no good reason for it to reside in the scripts/
> directory since it is only used in fs/unicode/.
> 
> Hence, move it from scripts/ to fs/unicode/.
> 
> In some cases, we bypass build artifacts in the normal build. The
> conventional way to do so is to surround the code with ifdef REGENERATE_*.
> 
> For example,
> 
>  - 7373f4f83c71 ("kbuild: add implicit rules for parser generation")
>  - 6aaf49b495b4 ("crypto: arm,arm64 - Fix random regeneration of S_shipped")
> 
> I rewrote the rule in a more kbuild'ish style.
> 
> In the normal build, utf8data.h is just shipped from the check-in file.
> 
> $ make
>   [ snip ]
>   SHIPPED fs/unicode/utf8data.h
>   CC      fs/unicode/utf8-norm.o
>   CC      fs/unicode/utf8-core.o
>   CC      fs/unicode/utf8-selftest.o
>   AR      fs/unicode/built-in.a
> 
> If you want to generate utf8data.h based on UCD, put *.txt files into
> fs/unicode/, then pass REGENERATE_UTF8DATA=1 from the command line.
> The mkutf8data tool will be automatically compiled to generate the
> utf8data.h from the *.txt files.
> 
> $ make REGENERATE_UTF8DATA=1
>   [ snip ]
>   HOSTCC  fs/unicode/mkutf8data
>   GEN     fs/unicode/utf8data.h
>   CC      fs/unicode/utf8-norm.o
>   CC      fs/unicode/utf8-core.o
>   CC      fs/unicode/utf8-selftest.o
>   AR      fs/unicode/built-in.a
> 
> I renamed the check-in utf8data.h to utf8data.h_shipped so that this
> will work for the out-of-tree build.
> 
> You can update it based on the latest UCD like this:
> 
> $ make REGENERATE_UTF8DATA=1 fs/unicode/
> $ cp fs/unicode/utf8data.h fs/unicode/utf8data.h_shipped
> 
> Also, I added entries to .gitignore and dontdiff.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>  - Make this work correctly with O= option

Thanks, I've updated my tree to use this version of the commit.

	     	     	     	    	 - Ted
