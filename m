Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4456ADEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 19:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbfGPRuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 13:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbfGPRuX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:50:23 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CA412173C;
        Tue, 16 Jul 2019 17:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563299421;
        bh=G8HZaTkY2j5PHpLqA7tOHBlpXfS88fwdr/i1I0KvhMc=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=SnmjZaJScqEkihvVKGQqkSTD5onJWfK+cHhQQBbW17pnjC+nIb+4uWvnjgWV9lKVf
         RdeeDLVXiDN2OyNKReRvzCItePqhEAfh7wbGzPcKWhCodyowk7MK4OaaP5GrxgXHmA
         SzXYxjU8ExAf2vD0GT0p9eiAqUSs49f1Guip83jU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFd5g44_axVHNMBzxSURQB_-R+Rif7cZcg7PyZ_SS+5hcy5jZA@mail.gmail.com>
References: <20190712081744.87097-1-brendanhiggins@google.com> <20190712081744.87097-5-brendanhiggins@google.com> <20190715221554.8417320665@mail.kernel.org> <CAFd5g47ikJmA0uGoavAFsh+hQvDmgsOi26tyii0612R=rt7iiw@mail.gmail.com> <CAFd5g44_axVHNMBzxSURQB_-R+Rif7cZcg7PyZ_SS+5hcy5jZA@mail.gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like logger
User-Agent: alot/0.8.1
Date:   Tue, 16 Jul 2019 10:50:20 -0700
Message-Id: <20190716175021.9CA412173C@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-07-16 01:37:34)
> On Tue, Jul 16, 2019 at 12:57 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > A `struct kunit_stream` is usually associated with a message that is
> > being built up over time like maybe an expectation; it is meant to
> > capture the idea that we might want to send some information out to
> > the user pertaining to some thing 'X', but we aren't sure that we
> > actually want to send it until 'X' is complete, but do to the nature
> > of 'X' it is easier to start constructing the message before 'X' is
> > complete.
> >
> > Consider a complicated expectation, there might be multiple conditions
> > that satisfy it and multiple conditions which could make it fail. As
> > we start exploring the input to the expectation we gain information
> > that we might want to share back with the user if the expectation were
> > to fail and we might get that information before we are actually sure
> > that the expectation does indeed fail.
> >
> > When we first step into the expectation we immediately know the
> > function name, file name, and line number where we are called and
> > would want to put that information into any message we would send to
> > the user about this expectation. Next, we might want to check a
> > property of the input, it may or may not be enough information on its
> > own for the expectation to fail, but we want to share the result of
> > the property check with the user regardless, BUT only if the
> > expectation as a whole fails.
> >
> > Hence, we can have multiple `struct kunit_stream`s associated with a
> > `struct kunit` active at any given time.

I'm coming back to this now after reading the rest of the patches that
deal with assertions and expectations. It looks like the string stream
is there to hold a few different pieces of information:

 - Line Number
 - File Name
 - Function Name

The above items could be stored in a structure on the stack that then
gets printed and formatted when the expectation or assertion fails. That
would make the whole string stream structure and code unnecessary.

The only hypothetical case where this can't be done is a complicated
assertion or expectation that does more than one check and can't be
written as a function that dumps out what went wrong. Is this a real
problem? Maybe such an assertion should just open code that logic so we
don't have to build up a string for all the other simple cases.

It seems far simpler to get rid of the string stream API and just have a
struct for this.

	struct kunit_fail_msg {
		const char *line;
		const char *file;
		const char *func;
		const char *msg;
	};

Then you can have the assertion macros create this on the stack (with
another macro?).

	#define DEFINE_KUNIT_FAIL_MSG(name, _msg) \
		struct kunit_fail_msg name =3D { \
			.line =3D  __LINE__, \
			.file =3D __FILE__, \
			.func =3D __func__, \
			.msg =3D _msg, \
		}

Note: I don't know if the __LINE__ above will use the macro location, so
this probably needs another wrapper to put the right line number there.

I don't want to derail this whole series on this topic, but it seems
like a bunch of code is there to construct this same set of information
over and over again into a buffer a little bit at a time and then throw
it away when nothing fails just because we may want to support the case
where we have some unstructured data to inform the user about.

Why not build in the structured part into the framework (i.e. the struct
above) so that it's always there and then add the string building part
later when we have to?

