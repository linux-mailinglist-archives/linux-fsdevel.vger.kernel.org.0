Return-Path: <linux-fsdevel+bounces-8924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD3B83C488
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 15:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25B328CDB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 14:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC6E63407;
	Thu, 25 Jan 2024 14:17:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968C95EE63;
	Thu, 25 Jan 2024 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192278; cv=none; b=a4YL7/vDBGxPgsDZdME+Q0eznLo1axqF4woDMRaAlHiiUIOz51RUffELswexnK7noAjm5s0rzM850oVKWgCKV2pB+f45lROiaTRzgbMPckWK0v70Ur5M/i+4yEzcLScN0B622Rr0m08fbD+i6BtyrTuuFWjm1emuzyuj/V6OIgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192278; c=relaxed/simple;
	bh=Td6MCQnzeN60nn9Rv1sdiDHqQG+WQ8QJwULnAd3LQfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFgzWqtuwJ1Dj+e7lNwcvo6J5LcMT9Rd7lF44jPtkjAWTH6XqJ1ZJtZmqGioQwS2b9kdINdJDoor/4pmwwKFQr3+Te4GiwUshnXOYefBubtVNo1rSxmD5lDJzKLf2drMlt8p+Oabhs5xtj6C9gxDVJgZu6Vety8ZnOjAhK1k8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40PEGgch062962;
	Thu, 25 Jan 2024 23:16:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Thu, 25 Jan 2024 23:16:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40PEGfdi062958
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 25 Jan 2024 23:16:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a9210754-2f94-4075-872f-8f6a18f4af07@I-love.SAKURA.ne.jp>
Date: Thu, 25 Jan 2024 23:16:42 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from
 virt-aa-helper
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>
Cc: Kevin Locke <kevin@kevinlocke.name>,
        Josh Triplett
 <josh@joshtriplett.org>,
        Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>
References: <ZbE4qn9_h14OqADK@kevinlocke.name>
 <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
 <202401240916.044E6A6A7A@keescook>
 <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
 <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/01/25 3:27, Linus Torvalds wrote:
> The whole cred use of current->in_execve in tomoyo should
> *also* be fixed, but I didn't even try to follow what it actually
> wanted.

Due to TOMOYO's unique domain transition (transits to new domain before
execve() succeeds and returns to old domain if execve() failed), TOMOYO
depends on a tricky ordering shown below.

----------
// a caller tries execve().
sys_execve() {
  do_execve() {
    do_execveat_common() {
      bprm_execve() {
        prepare_bprm_creds() {
          prepare_exec_creds() {
            prepare_creds() {
              security_prepare_creds() {
                tomoyo_cred_prepare() {
                  if (s->old_domain_info && !current->in_execve) { // false because s->old_domain_info == NULL.
                    s->domain_info = s->old_domain_info;
                    s->old_domain_info = NULL; 
                  }
                }
              }
            }
          }
        }
        current->in_execve = 1;
        do_open_execat() {
          (...snipped...)
          security_file_open() {
            tomoyo_file_open() // Not checked because current->in_execve == 1.
          }
          (...snipped...)
        }
        exec_binprm() {
          search_binary_handler() {
            security_bprm_check() {
              tomoyo_bprm_check_security() {
                if (!s->old_domain_info) { // true because s->old_domain_info == NULL.
                  tomoyo_find_next_domain() {
                    // Checks execute permission here.
                    s->old_domain_info = s->domain_info; // Remember old domain.
                    s->domain_info = domain; // Transit to new domain.
                  }
                }
              }
            }
            fmt->load_binary() { // e.g. load_script() in fs/binfmt_script.c
              open_exec() {
                // Not checked because current->in_execve == 1.
              }
            }
          }
          search_binary_handler() {
            security_bprm_check() {
              tomoyo_bprm_check_security() {
                if (!s->old_domain_info) { // false because s->old_domain_info != NULL.
                } else {
                  // Checks read permission here.
                }
              }
            }
          }
          // An error happens after s->domain_info was updated.
        }
        current->in_execve = 0;
        // No chance to restore s->domain_info.
      }
    }
  }
  // returning an error code to the caller.
}
// the caller retries execve().
sys_execve() {
  do_execve() {
    do_execveat_common() {
      bprm_execve() {
        prepare_bprm_creds() {
          prepare_exec_creds() {
            prepare_creds() {
              security_prepare_creds() {
                tomoyo_cred_prepare() {
                  if (s->old_domain_info && !current->in_execve) { // true because s->old_domain_info != NULL && current->in_execve == 0.
                    s->domain_info = s->old_domain_info; // Transit to old domain.
                    s->old_domain_info = NULL;
                  }
                }
              }
            }
          }
        }
        current->in_execve = 1;
        do_open_execat() {
          (...snipped...)
          security_file_open() {
            tomoyo_file_open() // Not checked because current->in_execve == 1.
          }
          (...snipped...)
        }
        exec_binprm() {
          search_binary_handler() {
            security_bprm_check() {
              tomoyo_bprm_check_security() {
                if (!s->old_domain_info) { // true because s->old_domain_info == NULL.
                  tomoyo_find_next_domain() {
                    // Checks execute permission here.
                    s->old_domain_info = s->domain_info; // Remember old domain.
                    s->domain_info = domain; // Transit to new domain.
                  }
                }
              }
            }
            fmt->load_binary() { // e.g. load_script() in fs/binfmt_script.c
              open_exec() {
                // Not checked because current->in_execve == 1.
              }
            }
          }
          search_binary_handler() {
            security_bprm_check() {
              tomoyo_bprm_check_security() {
                if (!s->old_domain_info) { // false because s->old_domain_info != NULL.
                } else {
                  // Checks read permission here.
                }
              }
            }
          }
          fmt->load_binary() { // e.g. load_elf_binary() in fs/binfmt_elf.c
            begin_new_exec() {
              security_bprm_committed_creds() {
                tomoyo_bprm_committed_creds() {
                  s->old_domain_info = NULL; // Forget old domain.
                }
              }
            }
          }
        }
        current->in_execve = 0;
      }
    }
  }
}
----------

Commit 978ffcbf00d8 ("execve: open the executable file before doing anything else")
broke the ordering and commit 4759ff71f23e ("exec: Check __FMODE_EXEC instead of
in_execve for LSMs") and commit 3eab830189d9 ("uselib: remove use of __FMODE_EXEC")
fixed the regression.

But current->in_execve remains required unless an LSM callback that is called when
an execve() request failed which existed as security_bprm_free() until Linux 2.6.28
revives...


