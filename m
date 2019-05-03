Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177751263A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 03:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfECBuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 21:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfECBuT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 21:50:19 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E84C206C3;
        Fri,  3 May 2019 01:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556848217;
        bh=qaceKMSCeRC9dQeLapwfc7pBEOFW2deb4iZaTSLxXow=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F+9ptLcE+9kv81snBWwlIRBpJnHQqZ+jaEKwoBkJugi6zfZoeiHqGbmzJoi7fFmLY
         /Z2gIlXTghYOeTaWRPeBXmt4j0bKOYOd/VQ0o0FWbsXhlpQCWKDFHgFofLU5tItp7Q
         FsOFpVjldizU0eaFVgiupp/X1ndMgJhqPUgLIml0=
Subject: Re: [PATCH v2 04/17] kunit: test: add kunit_stream a std::stream like
 logger
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-5-brendanhiggins@google.com>
From:   shuah <shuah@kernel.org>
Message-ID: <ead23600-eecd-cf74-bdd1-94a6964e29b2@kernel.org>
Date:   Thu, 2 May 2019 19:50:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501230126.229218-5-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/19 5:01 PM, Brendan Higgins wrote:
> A lot of the expectation and assertion infrastructure prints out fairly
> complicated test failure messages, so add a C++ style log library for
> for logging test results.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>   include/kunit/kunit-stream.h |  85 ++++++++++++++++++++
>   include/kunit/test.h         |   2 +
>   kunit/Makefile               |   3 +-
>   kunit/kunit-stream.c         | 149 +++++++++++++++++++++++++++++++++++
>   kunit/test.c                 |   8 ++
>   5 files changed, 246 insertions(+), 1 deletion(-)
>   create mode 100644 include/kunit/kunit-stream.h
>   create mode 100644 kunit/kunit-stream.c
> 
> diff --git a/include/kunit/kunit-stream.h b/include/kunit/kunit-stream.h
> new file mode 100644
> index 0000000000000..d457a54fe0100
> --- /dev/null
> +++ b/include/kunit/kunit-stream.h
> @@ -0,0 +1,85 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * C++ stream style string formatter and printer used in KUnit for outputting
> + * KUnit messages.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#ifndef _KUNIT_KUNIT_STREAM_H
> +#define _KUNIT_KUNIT_STREAM_H
> +
> +#include <linux/types.h>
> +#include <kunit/string-stream.h>
> +
> +struct kunit;
> +
> +/**
> + * struct kunit_stream - a std::stream style string builder.
> + *
> + * A std::stream style string builder. Allows messages to be built up and
> + * printed all at once.
> + */
> +struct kunit_stream {
> +	/* private: internal use only. */
> +	struct kunit *test;
> +	spinlock_t lock; /* Guards level. */
> +	const char *level;
> +	struct string_stream *internal_stream;
> +};
> +
> +/**
> + * kunit_new_stream() - constructs a new &struct kunit_stream.
> + * @test: The test context object.
> + *
> + * Constructs a new test managed &struct kunit_stream.
> + */
> +struct kunit_stream *kunit_new_stream(struct kunit *test);
> +
> +/**
> + * kunit_stream_set_level(): sets the level that string should be printed at.
> + * @this: the stream being operated on.
> + * @level: the print level the stream is set to output to.
> + *
> + * Sets the print level at which the stream outputs.
> + */
> +void kunit_stream_set_level(struct kunit_stream *this, const char *level);
> +
> +/**
> + * kunit_stream_add(): adds the formatted input to the internal buffer.
> + * @this: the stream being operated on.
> + * @fmt: printf style format string to append to stream.
> + *
> + * Appends the formatted string, @fmt, to the internal buffer.
> + */
> +void __printf(2, 3) kunit_stream_add(struct kunit_stream *this,
> +				     const char *fmt, ...);
> +
> +/**
> + * kunit_stream_append(): appends the contents of @other to @this.
> + * @this: the stream to which @other is appended.
> + * @other: the stream whose contents are appended to @this.
> + *
> + * Appends the contents of @other to @this.
> + */
> +void kunit_stream_append(struct kunit_stream *this, struct kunit_stream *other);
> +
> +/**
> + * kunit_stream_commit(): prints out the internal buffer to the user.
> + * @this: the stream being operated on.
> + *
> + * Outputs the contents of the internal buffer as a kunit_printk formatted
> + * output.
> + */
> +void kunit_stream_commit(struct kunit_stream *this);
> +
> +/**
> + * kunit_stream_clear(): clears the internal buffer.
> + * @this: the stream being operated on.
> + *
> + * Clears the contents of the internal buffer.
> + */
> +void kunit_stream_clear(struct kunit_stream *this);
> +
> +#endif /* _KUNIT_KUNIT_STREAM_H */
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 819edd8db4e81..4668e8a635954 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -11,6 +11,7 @@
>   
>   #include <linux/types.h>
>   #include <linux/slab.h>
> +#include <kunit/kunit-stream.h>
>   
>   struct kunit_resource;
>   
> @@ -171,6 +172,7 @@ struct kunit {
>   	void (*vprintk)(const struct kunit *test,
>   			const char *level,
>   			struct va_format *vaf);
> +	void (*fail)(struct kunit *test, struct kunit_stream *stream);
>   };
>   
>   int kunit_init_test(struct kunit *test, const char *name);
> diff --git a/kunit/Makefile b/kunit/Makefile
> index 275b565a0e81f..6ddc622ee6b1c 100644
> --- a/kunit/Makefile
> +++ b/kunit/Makefile
> @@ -1,2 +1,3 @@
>   obj-$(CONFIG_KUNIT) +=			test.o \
> -					string-stream.o
> +					string-stream.o \
> +					kunit-stream.o
> diff --git a/kunit/kunit-stream.c b/kunit/kunit-stream.c
> new file mode 100644
> index 0000000000000..93c14eec03844
> --- /dev/null
> +++ b/kunit/kunit-stream.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * C++ stream style string formatter and printer used in KUnit for outputting
> + * KUnit messages.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <kunit/kunit-stream.h>
> +#include <kunit/string-stream.h>
> +
> +const char *kunit_stream_get_level(struct kunit_stream *this)
> +{
> +	unsigned long flags;
> +	const char *level;
> +
> +	spin_lock_irqsave(&this->lock, flags);
> +	level = this->level;
> +	spin_unlock_irqrestore(&this->lock, flags);
> +
> +	return level;
> +}
> +
> +void kunit_stream_set_level(struct kunit_stream *this, const char *level)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&this->lock, flags);
> +	this->level = level;
> +	spin_unlock_irqrestore(&this->lock, flags);
> +}
> +
> +void kunit_stream_add(struct kunit_stream *this, const char *fmt, ...)
> +{
> +	va_list args;
> +	struct string_stream *stream = this->internal_stream;
> +
> +	va_start(args, fmt);
> +
> +	if (string_stream_vadd(stream, fmt, args) < 0)
> +		kunit_err(this->test, "Failed to allocate fragment: %s\n", fmt);
> +
> +	va_end(args);
> +}
> +
> +void kunit_stream_append(struct kunit_stream *this,
> +				struct kunit_stream *other)
> +{
> +	struct string_stream *other_stream = other->internal_stream;
> +	const char *other_content;
> +
> +	other_content = string_stream_get_string(other_stream);
> +
> +	if (!other_content) {
> +		kunit_err(this->test,
> +			  "Failed to get string from second argument for appending.\n");
> +		return;
> +	}
> +
> +	kunit_stream_add(this, other_content);
> +}
> +
> +void kunit_stream_clear(struct kunit_stream *this)
> +{
> +	string_stream_clear(this->internal_stream);
> +}
> +
> +void kunit_stream_commit(struct kunit_stream *this)
> +{
> +	struct string_stream *stream = this->internal_stream;
> +	struct string_stream_fragment *fragment;
> +	const char *level;
> +	char *buf;
> +
> +	level = kunit_stream_get_level(this);
> +	if (!level) {
> +		kunit_err(this->test,
> +			  "Stream was committed without a specified log level.\n");
> +		level = KERN_ERR;
> +		kunit_stream_set_level(this, level);
> +	}
> +
> +	buf = string_stream_get_string(stream);
> +	if (!buf) {
> +		kunit_err(this->test,
> +			 "Could not allocate buffer, dumping stream:\n");
> +		list_for_each_entry(fragment, &stream->fragments, node) {
> +			kunit_err(this->test, fragment->fragment);
> +		}
> +		kunit_err(this->test, "\n");
> +		goto cleanup;
> +	}
> +
> +	kunit_printk(level, this->test, buf);
> +	kfree(buf);
> +
> +cleanup:
> +	kunit_stream_clear(this);
> +}
> +
> +static int kunit_stream_init(struct kunit_resource *res, void *context)
> +{
> +	struct kunit *test = context;
> +	struct kunit_stream *stream;
> +
> +	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
> +	if (!stream)
> +		return -ENOMEM;
> +	res->allocation = stream;
> +	stream->test = test;
> +	spin_lock_init(&stream->lock);
> +	stream->internal_stream = new_string_stream();
> +
> +	if (!stream->internal_stream)
> +		return -ENOMEM;

What happens to stream? Don't you want to free that?

> +
> +	return 0;
> +}
> +
> +static void kunit_stream_free(struct kunit_resource *res)
> +{
> +	struct kunit_stream *stream = res->allocation;
> +
> +	if (!string_stream_is_empty(stream->internal_stream)) {
> +		kunit_err(stream->test,
> +			 "End of test case reached with uncommitted stream entries.\n");
> +		kunit_stream_commit(stream);
> +	}
> +
> +	destroy_string_stream(stream->internal_stream);
> +	kfree(stream);
> +}
> +
> +struct kunit_stream *kunit_new_stream(struct kunit *test)
> +{
> +	struct kunit_resource *res;
> +
> +	res = kunit_alloc_resource(test,
> +				   kunit_stream_init,
> +				   kunit_stream_free,
> +				   test);
> +
> +	if (res)
> +		return res->allocation;
> +	else
> +		return NULL;
> +}
> diff --git a/kunit/test.c b/kunit/test.c
> index 541f9adb1608c..f7575b127e2df 100644
> --- a/kunit/test.c
> +++ b/kunit/test.c
> @@ -63,12 +63,20 @@ static void kunit_vprintk(const struct kunit *test,
>   			  "kunit %s: %pV", test->name, vaf);
>   }
>   
> +static void kunit_fail(struct kunit *test, struct kunit_stream *stream)
> +{
> +	kunit_set_success(test, false);
> +	kunit_stream_set_level(stream, KERN_ERR);
> +	kunit_stream_commit(stream);
> +}
> +
>   int kunit_init_test(struct kunit *test, const char *name)
>   {
>   	spin_lock_init(&test->lock);
>   	INIT_LIST_HEAD(&test->resources);
>   	test->name = name;
>   	test->vprintk = kunit_vprintk;
> +	test->fail = kunit_fail;
>   
>   	return 0;
>   }
> 

thanks,
-- Shuah
