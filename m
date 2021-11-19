Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925BC456FE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 14:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhKSNvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 08:51:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235588AbhKSNvg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:51:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A09B761A8A;
        Fri, 19 Nov 2021 13:48:32 +0000 (UTC)
Date:   Fri, 19 Nov 2021 14:48:30 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] proc: Make the proc_create[_data]() stubs static inlines
Message-ID: <20211119134830.3siznojrghkrxmzf@wittgenstein>
References: <20211116131112.508304-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211116131112.508304-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 02:11:12PM +0100, Hans de Goede wrote:
> Change the proc_create[_data]() stubs which are used when CONFIG_PROC_FS
> is not set from #defines to a static inline stubs.
> 
> Thix should fix clang -Werror builds failing due to errors like this:
> 
> drivers/platform/x86/thinkpad_acpi.c:918:30: error: unused variable
>  'dispatch_proc_ops' [-Werror,-Wunused-const-variable]
> 
> Fixing this in include/linux/proc_fs.h should ensure that the same issue
> is also fixed in any other drivers hitting the same -Werror issue.
> 
> Cc: platform-driver-x86@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Hmkay, seems ok if this is required to please clang with -Werror.
Also using statement expressions to implement these nop helpers for
!CONFIG_PROC_FS seems a bit strange to me in the first place. Especially
since they seem to be sprinkled in alongside other static inline nops.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

> Note the commit message says "should fix" because I could not actually
> be bothered to verify this. The whole notion of combining:
> 1. clang
> 2. -Werror
> 3. -Wunused-const-variable
> Is frankly a bit crazy, causing way too much noise and has already
> cost me too much time IMHO.
> ---
>  include/linux/proc_fs.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> index 069c7fd95396..3d19453fb6b3 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -178,8 +178,14 @@ static inline struct proc_dir_entry *proc_mkdir_mode(const char *name,
>  #define proc_create_seq(name, mode, parent, ops) ({NULL;})
>  #define proc_create_single(name, mode, parent, show) ({NULL;})
>  #define proc_create_single_data(name, mode, parent, show, data) ({NULL;})
> -#define proc_create(name, mode, parent, proc_ops) ({NULL;})
> -#define proc_create_data(name, mode, parent, proc_ops, data) ({NULL;})
> +
> +static inline struct proc_dir_entry *proc_create(
> +	const char *, umode_t, struct proc_dir_entry *, const struct proc_ops *)
> +{ return NULL; }
> +
> +static inline struct proc_dir_entry *proc_create_data(
> +	const char *, umode_t, struct proc_dir_entry *, const struct proc_ops *, void *)
> +{ return NULL; }
>  
>  static inline void proc_set_size(struct proc_dir_entry *de, loff_t size) {}
>  static inline void proc_set_user(struct proc_dir_entry *de, kuid_t uid, kgid_t gid) {}
> -- 
> 2.31.1
> 
